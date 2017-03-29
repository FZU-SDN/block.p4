/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.24
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

/* resubmit feature in P4 */

/* resubmit metadata */

header_type resubmit_metadata_t {
	fields {
		resubmit_tag : 1;
	}
}

metadata resubmit_metadata_t resubmit_metadata;

/* resubmit field list */

field_list resubmit_fl {
	standard_metadata;
	resubmit_metadata;
}

/* resubmit select in ingress stage */

action resubmit_action(value) {
	modify_field(resubmit_metadata.resubmit_tag, value);
	resubmit(resubmit_fl);
}

table resubmit_select {
	reads {
		ipv4.srcAddr : exact;
		ipv4.dstAddr : exact;
	}
	actions {_nop; resubmit_action;}
}

/* resubmit forward in egress stage */

counter resubmit_counter {
	type : packets;
	static : resubmit_process;
	instance_count : 10;
}

action resubmit_forward(port, index) {
	modify_field(standard_metadata.egress_spec, port);
	count(resubmit_counter, index);
}

table resubmit_process {
	reads {
		resubmit_metadata.resubmit_tag : exact;
	}
	actions {_nop; resubmit_forward;}
}

/* control program */

control resubmit_ingress { // call this CP in ingress stage
	apply(resubmit_select);
}

control resubmit_egress { // call this CP in the end of ingress stage
	apply(resubmit_process);
}