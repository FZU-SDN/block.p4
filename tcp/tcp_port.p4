/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.22
 *********************************/

 /* layer4 port match */

// tcp.dstPort = 22 => telnet
// tcp.dstPort = 23 => ssh
// ...

table tcp_port {
	reads {
		tcp.dstPort : exact;
	}
	actions {
		_nop; _drop;
		// TODO 
	}
}

control tcp_port_process {
	if (valid(tcp)) {
		apply(tcp_port);
	}
}