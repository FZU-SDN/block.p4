/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.23
 *********************************/

/*********************************
 This file is used to add port mirror
 features to l2 switch.
 We refered to the P4 program 
 offered by Barefoot.
 *********************************/

/*
    action: clone_ingress_pkt_to_egress(clone_spec [ , field_list ] )

    "In addition to other session attributes, clone_spec determines 
    the egress specification (standard metadata egress_spec) that 
    is presented to the Buffering Mechanism."

    clone_spec = mirror_id in this example.
 */

/*
	Packet Mirror Processing: 

	pkt -> pm_ingress -> mirror -> ... -> pm_egress -> listen port    
	
	------(ingress)------||------(egress)------> pipeline
 */

/* easy local metadata */
header_type local_metadata_t {
    fields {
        mirror_id : 1; // used in pkt mirroring
    }
}

metadata local_metadata_t local_metadata;

/* Packet Mirroring in ingress */

field_list mirror_field_list {
	//standard_metadata;
	local_metadata.mirror_id;
}

// Hint: add your runtime command.
// mirroring_add [mirror_id] [output_port]
action mirror_select(id) { 
	modify_field(local_metadata.mirror_id, id);
	clone_ingress_pkt_to_egress(id, mirror_field_list);
}

// select the pkt based on its dstAddr and srcAddr, and make mirror.
table pm_ingress { 
	reads {
		ipv4.srcAddr : exact;
		ipv4.dstAddr : exact;
	}
	actions {_nop; mirror_select;}
}

/* Packet Mirroring in egress */

// the counter used to count the mirror pkt
counter mirror_counter {
	type : packets;
	static : pm_egress;
	instance_count : 10;
}

// count the mirror pkt.
action mirror_execute(index) {
	count(mirror_counter, index);
}

// reads the field, execute the action with the mirror pkt.
table pm_egress {
	reads {
		// instance_type is used to distinguish the mirror pkt
		// from the original pkt.
		// mirror packet => instance_type = 1
		standard_metadata.instance_type : exact; 
	}
	actions {_nop; mirror_execute;}
}

/* Control Program */

// Hint: this control program must add to the 
// beginning of ingress pipeline.
control port_mirror_ingress {
	apply(pm_ingress);
}

// Hint: this control program must add to the 
// end of egress pipeline.
control port_mirror_egress {
	apply(pm_egress);
}
