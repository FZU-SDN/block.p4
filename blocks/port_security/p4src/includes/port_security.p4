/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.21
 *********************************/

// port_security.p4

table port_security {
	reads {
		ethernet.srcAddr : exact;
		port_sec_metadata.port : exact;
	}
	actions {_nop; _drop;}
}

control port_security_process {
    apply(port_security);
}