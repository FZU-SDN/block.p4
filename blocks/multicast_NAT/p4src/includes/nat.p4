// FuZhou University, SDNLab
// Added by Chen, 2017.3.25

// Simple NAT Hint:
// This demo is used to present the NAT implementation using P4.
// It depends on the target named "simple_switch". The key 
// technology of it was the engine named PRE(Packet Replication 
// Engine) between the ingress stage and the egress stage.
//
// To get more informations about this demo, you can refer to 
// this URL: https://github.com/FOXNEOAdvancedTechnology/mc_nat_P4
// and issue here: https://github.com/p4lang/tutorials/issues/22

/* The BMv2-Simple_Switch-specific Ingress Metadata */
header_type intrinsic_metadata_t {
    fields {
        mcast_grp : 16;                        /* multicast group */
        lf_field_list : 32;                    /* Learn filter field list */
        egress_rid : 16;                       /* replication index */
        ingress_global_timestamp : 32;
    }
}
metadata intrinsic_metadata_t intrinsic_metadata;

/* IPv4 CheckSum */
field_list ipv4_checksum_list {
    ipv4.version;
    ipv4.ihl;
    ipv4.diffserv;
    ipv4.totalLen;
    ipv4.identification;
    ipv4.flags;
    ipv4.fragOffset;
    ipv4.ttl;
    ipv4.protocol;
    ipv4.srcAddr;
    ipv4.dstAddr;
}

field_list_calculation ipv4_checksum {
    input {
        ipv4_checksum_list;
    }
    algorithm : csum16;
    output_width : 16;
}

calculated_field ipv4.hdrChecksum  {
    verify ipv4_checksum;
    update ipv4_checksum;
}

/* Simple NAT */

// counter
counter nat_counter {
	type : packets;
	static : nat;
	instance_count : 10;
}

// Set the output muticast group
action set_output_mcg(multicast_group) {
	modify_field(intrinsic_metadata.mcast_grp, multicast_group);
}

// Table to add the output muticast group to the packet based on
// the original IP Address
table set_mcg {
	reads {
		ipv4.dstAddr : exact;
	}
	actions {_nop; set_output_mcg;}
}

action do_ip_nat(ip) {
	modify_field(ipv4.dstAddr, ip);
	add_to_field(ipv4.ttl, -1); // Just for fun :)
	count(nat_counter, 0);
}

// Table to do the network address translation on the IPv4 dstAddr
// based on the original IPv4 Address and the egress Replication ID
// (rid)
table nat {
	reads {
		intrinsic_metadata.egress_rid : exact;
		ipv4.dstAddr : exact;
	}
	actions {_nop; do_ip_nat;}
}

/* Control Program */

control nat_ingress {
	apply(set_mcg);
}

control nat_egress {
	apply(nat);
}