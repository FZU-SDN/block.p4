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

/* tcp syn fin check */

header_type tcp_tag_t {
	fields {
		tag : 1; // 1 = tagged
	}
}
metadata tcp_tag_t tcp_tag;

counter tcp_pkt_count {
	type : packets;
	static : tcp_check;
	instance_count : 10;
}

action hit_tag(index) {
	modify_field(tcp_tag.tag, 1);
	count(tcp_pkt_count, index); // syn => cnt0, fin => cnt1
}

table tcp_check { 
	reads {
		tcp.flags : exact;
	}
	actions {_nop; hit_tag;}
}

control tcp_check_c {
	if (valid(tcp)) {
		apply(tcp_check);
	}
}
