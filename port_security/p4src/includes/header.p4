/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.21
 *********************************/

// header.p4

header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}

header_type intrinsic_metadata_t {
    fields {
        mcast_grp : 4;
        egress_rid : 4;
        mcast_hash : 16;
        lf_field_list: 32;
    }
}

header_type port_sec_metadata_t {
	fields {
		port : 4;
	}
}