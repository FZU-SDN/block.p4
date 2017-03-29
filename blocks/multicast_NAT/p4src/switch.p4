/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.25
 *********************************/

/*********************************
 This file is used to add NAT
 feature to l2 switch.
 We refered to the P4 program 
 offered by Barefoot.
 *********************************/

// 10.0.0.10 => 10.0.0.3

#include "includes/header.p4"
#include "includes/parser.p4"
#include "includes/nat.p4"

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
    nat_ingress();
}

control egress {
    if (standard_metadata.ingress_port == standard_metadata.egress_port) {
        apply(mcast_src_pruning);
    }
    nat_egress();
}
