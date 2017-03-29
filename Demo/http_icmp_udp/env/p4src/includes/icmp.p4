/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.21
 *********************************/

// icmp of death
counter icmp_counter {
	type : packets;
	static : icmp_of_death;
	instance_count : 16384;
}

action icmp_cnt(index) {
	count(icmp_counter, index);
} 

table icmp_of_death {
	reads {
		ipv4.srcAddr : exact;
	}
	actions {_nop; _drop; icmp_cnt;}
}

// icmp forbidden 
table icmp_forbidden {
	reads {
		ipv4.srcAddr : exact;
	}
	actions {_nop; _drop;}
}

control icmp_security_process {
	if (valid(icmp)) {
		// forbidden icmp
		apply(icmp_forbidden);
		// icmp of death
		apply(icmp_of_death);
	}
}

