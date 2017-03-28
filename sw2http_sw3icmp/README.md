## Demo: sw2http_sw3icmp

This Demo present a topologic that owns four switches and six hosts:

```
switches: s1 s2 s3 s4
hosts: h1 h2 h3 h4 h5 h6
links: h1-s1 h2-s1 h3-s1 h4-s4 h5-s4 h6-s4 s1-s2 s1-s3 s2-s4 s3-s4
```

To run this demo, first start the mininet and then "learning MAC" like other demo did. Then apply the commands in dir `cmd` by `./run.sh`.

Then you can see different features that different switches supported: s1 and s4 do nothing to the incoming packets; s2 has been deployed to count the http packets with the TCP port 80, and drop any other packets include icmp, udp and so on; s3 only permit the icmp packets that srcAddr is `10.0.0.1` or `10.0.0.4`, that means only h1 and h4 can ping each other successfully through the network, Besides, s3 drop all the incoming UDP packets and then count it.

To validate it, first apply `pingall` in the mininet:

```
mininet> pingall
*** Ping: testing ping reachability
h1 -> h2 h3 h4 X X 
h2 -> h1 h3 X X X 
h3 -> h1 h2 X X X 
h4 -> h1 X X h5 h6 
h5 -> X X X h4 h6 
h6 -> X X X h4 h5 
*** Results: 53% dropped (14/30 received)
```

as we can see in the result, only the icmp packets that from h1 to h4 or from h4 to h1 can ping successfully through the network.

Then you can start sending packets by running the script named `send.py`. One thing should be noticed that, I writed this script with the help of `scapy`, it is a perfect packet generating tool that writed in Python.

The `send.py` first send 500 tcp packets which port is 80 through the virtual socket `s1-eth1`. The packet it send has the source IPAddr `10.0.0.1` and destination IPAddr `10.0.0.4`. Then the script send 500 udp packets the same way.

Then check the counter in the s2 and s3 by assigning the thrift port.

s2:

```
sudo ./simple_switch_CLI --thrift-port 22223

RuntimeCmd: counter_read http_counter 0
http_counter[0]=  BmCounterValue(packets=500, bytes=30000)
```

s3:

```
sudo ./simple_switch_CLI --thrift-port 22224

RuntimeCmd: counter_read udp_pkt_cnt 0
udp_pkt_cnt[0]=  BmCounterValue(packets=2414, bytes=675588)
```

The results proved that the specific features have been deployed to the switch s2 and s3.

You can also start a wireshark process to capture the packets by assigning the socket `s4-eth1` to validate it.

Chen, 2017.3.28