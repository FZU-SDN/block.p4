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

#include "includes/header.p4"
#include "includes/parser.p4"
// blocks.p4
#include "blocks/icmp.p4"
#include "blocks/port_security.p4"
#include "blocks/port_mirror.p4"
#include "blocks/trTCM.p4"
#include "blocks/udp_flood.p4"
#include "blocks/resubmit.p4"

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
    // port security:
    modify_field(port_sec_metadata.port, port);
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
    // port mirror:
    port_mirror_ingress();

    apply(smac);
    apply(dmac);

    // trTCM:
    trTCM_process();
    // resubmit:
    resubmit_ingress();
    resubmit_egress();
}

control egress {
    if (standard_metadata.ingress_port == standard_metadata.egress_port) {
        apply(mcast_src_pruning);
    }

    // l2 port security:
    port_security_process();
    // icmp security:
    icmp_security_process();
    // udp flood:
    udp_flood_process();

    // port mirror:
    port_mirror_egress();
}
