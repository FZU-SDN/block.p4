/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.22
 *********************************/

counter udp_pkt_cnt {
	type : packets;
	static : udp_flood;
	instance_count : 10;
}

action udp_drop() {
	count(udp_pkt_cnt, 0);
	drop();
}

table udp_flood {
	actions {_nop; udp_drop;}
}

control udp_flood_process {
	if (valid(udp)) {
		apply(udp_flood);
	}
}
