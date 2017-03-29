# Muticast NAT P4

## TODO:

### Common PreSteps

start the mininet:

```
./run_demo.sh
```

deploy the scripts:

```
./add_entry.sh

cd mclearn
./mc_learn.sh
```

validate:

```
mininet> pingall
```

### Target Specific Steps

1.start the muticast NAT feature in the P4 switch:

```
cd cmd
./nat.sh
```

2.start xterm of h1:

```
mininet> xterm h1
```

3.start the wireshark and listen to the port `s1-eth1`;

4.h1 send 100 pkts to the dst IP Address `10.0.0.10` on its xterm:

```
./send.py
```

Then you can see mutiple TCP pkts from `10.0.0.1` to `10.0.0.10` on wireshark.

5.wireshark listen to the port `s1-eth2`;

6.send 100 pkts again:

```
./send.py
```

You can see mutiple pkts from `10.0.0.1` to `10.0.0.3`. It validates that the switch used NAT to change the dst IP address on the pkts from `10.0.0.10` to `10.0.0.3`.

## Explaination

About the muticast feature in P4, @vgurevich has a greatful explaination on it. See [question about multicast](https://github.com/p4lang/tutorials/issues/22) for more informations.

## Qustions: Help Waited

1.The `egress_port` field in standard metadata is not binding to an output port, that means if you define the `egress_port` with value 3 by using the command `mc_node_create 1 3`, the packet would only pass the egress port 3 but not the output port 3. You can use wireshark to capture the packets on port `s1-eth3` to validate it.

2.It seems to be unsecessful when I try to write `s1.txt` like this:

```
table_set_default set_mcg _nop
table_set_default nat _nop
table_add set_mcg set_output_mcg 10.0.0.10 => 10
table_add nat do_ip_nat 1 10.0.0.10 => 10.0.0.3
mc_node_create 1 3
mc_mgrp_create 10
mc_node_associate 10 0
```

I create only one muticast node that owned both replication ID 1 and the egress port 3. However, no packet can be captured in both `s1-eth2` and `s1-eth3`. I check the counter `nat_counter` using the command `counter_read nat_counter 0` and it showed me that the action `do_ip_nat` has not been applied at all. I fixed it by adding another muticast node. 


Chen, 2017.3.25