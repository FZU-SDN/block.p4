/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.22
 *********************************/

table udp_flood {
	actions {_nop; _drop;}
}

control udp_flood_process {
	if (valid(udp)) {
		apply(udp_flood);
	}
}