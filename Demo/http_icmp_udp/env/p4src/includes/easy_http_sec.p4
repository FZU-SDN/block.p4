/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.27
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

/*********************************
    HTTP distinct + security
 *********************************/

/* http packets counter */
counter http_counter {
	type : packets;
	static : http_distinct;
	instance_count : 5;
}

action do_http_security() {
	count(http_counter, 0); // increase the cnt by 1
	// TODO: add security feature
}

/* http distinct */
table http_distinct {
	reads {
		tcp.dstPort : exact;
	}
	actions {_nop; _drop; do_http_security;}
}

/* Control Program */
control http_process {
	apply(http_distinct);
}

