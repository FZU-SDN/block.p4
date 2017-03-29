/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.21
 *********************************/

// port_security.p4

// metadata: port_security_metadata
header_type port_security_metadata_t {
	fields {
		port_sec_metadata.port : 4;
	}
}
metadata port_security_metadata_t port_security_metadata;

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
