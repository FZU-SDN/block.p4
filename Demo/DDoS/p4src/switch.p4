/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.29
 *********************************/

/* Copyright 2017 FuZhou University SDNLab, Edu. 
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
   http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

/*********************************
    template: switch.p4
 *********************************/

#include "includes/header.p4"
#include "includes/parser.p4"
#include "includes/white_list.p4"
#include "includes/trTCM.p4"
#include "includes/udp_flood.p4"
#include "includes/icmp_security.p4"
#include "includes/tcp_check.p4"

#define ttl_limitation 00100000 

// table and action

action _drop() {
    drop();
}

action _nop() {
}

#define MAC_LEARN_RECEIVER 1024

field_list mac_learn_digest {
    ethernet.srcAddr;
    standard_metadata.ingress_port;
}

action mac_learn() {
    generate_digest(MAC_LEARN_RECEIVER, mac_learn_digest);
}

table smac {
    reads {
        ethernet.srcAddr : exact;
    }
    actions {mac_learn; _nop;}
    size : 512;
}

action forward(port) {
    modify_field(standard_metadata.egress_spec, port);
}

action broadcast() {
    modify_field(intrinsic_metadata.mcast_grp, 1);
}

table dmac {
    reads {
        ethernet.dstAddr : exact;
    }
    actions {
        forward;
        broadcast;
    }
    size : 512;
}

table mcast_src_pruning {
    reads {
        standard_metadata.instance_type : exact;
    }
    actions {_nop; _drop;}
    size : 1;
}

control ingress {
    apply(smac);
    apply(dmac);
    
    white_list_check();                 // white list check
    if (white_metadata.white != 1) {    // not in white list
        if (valid(tcp)) {               // DDoS Defence: TCP FIN or SYN check
            tcp_check_c();              // tcp syn fin check
        }
    } else {}                           // in white list => pass
}

table egress_drop {                     // set default => drop
    actions {_nop; _drop;}
}

control egress {
    if (standard_metadata.ingress_port == standard_metadata.egress_port) {
        apply(mcast_src_pruning);
    }

    if (ipv4.ttl < ttl_limitation) {    // DDoS Defence: TTL
        apply(egress_drop);
    }

    if (valid(tcp)) {
        if (tcp_tag.tag == 1) {         // syn or fin packet
            trTCM_process();            // trTCM packet filter
        }
    } else if (valid(udp)) {            // udp => drop
        udp_flood_process();
    }

    if (valid(icmp)) {                  // icmp security
        icmp_security_process(); 
    }
}
