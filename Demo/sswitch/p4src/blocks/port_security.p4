/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.21
 *********************************/

/* Copyright 2017 FuZhou University SDNLab, Edu. 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

// port_security.p4

// metadata: port_security_metadata
header_type port_security_metadata_t {
	fields {
		port : 4;
	}
}
metadata port_security_metadata_t port_sec_metadata;

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
