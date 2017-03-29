/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.27
 *********************************/

/*

Copyright 2017 FuZhou University SDNLab, Edu. 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

 */

/* ECMP: Action Profile */

/* field list */
field_list l3_hash_fields {
	ipv4.srcAddr;
	ipv4.protocol;
}

/* hash calculation */
field_list_calculation ecmp_hash {
	input { l3_hash_fields; }
	algorithm : bmv2_hash;
	output_width : 16;
}

/* action selector: based on the ecmp_hash */
action_selector ecmp_selector {
	selection_key : ecmp_hash;
}

/* set next hop */
action set_nexthop(port) {
	modify_field(standard_metadata.egress_spec, port);
	count(ecmp_counter, port); // calculate the pkt number for each port
}

/* ecmp action profile */
action_profile ecmp_action_profile {
	actions {_nop; set_nexthop;}
	size : 64;
	dynamic_action_selection : ecmp_selector;
}

/* ecmp counter */
counter ecmp_counter {
	type : packets;
	static : ecmp;
	instance_count : 10;
}

table ecmp {
	reads {
		ipv4.dstAddr : exact;
	}
	action_profile : ecmp_action_profile;
}

/* Control Program */
control ecmp_process {
	apply(ecmp);
}
