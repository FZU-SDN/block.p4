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
