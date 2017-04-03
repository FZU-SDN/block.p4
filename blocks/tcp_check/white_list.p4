/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.4.2
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

/* White List */

header_type white_metadata_t {
	fields {
		white : 1; // 1 = check pass
	}
}
metadata white_metadata_t white_metadata;

action white_action() {
	modify_field(white_metadata.white, 1);
}

table white_list {
	reads {
		ipv4.srcAddr : exact;
	}
	actions {_nop; white_action;}
}

control white_list_check {
	apply(white_list);
}
