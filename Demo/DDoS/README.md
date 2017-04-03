## DDoS P4

This demo is based on [slices_demo5]() which contains four switches.

The commands to try this demo:

```
In terminal A:
./run_demo.sh

In terminal B:
./add_entry.sh
cd mclearn
./learn.sh
cd cmd
./run.sh

In terminal C:
./send.py
```

After that, you will see a lot of TCP packets that assigned the flags with SYN or FIN. In this demo, s1 is a normal switch that forward all the tcp packets but s2, s3 and s4 are present as firwalls, they will drop all the FIN/SYN packets that was tagged with color red and color yellow.

To validate it, you can start a Wireshark process to capture packets in `s1-eth1`, `s2-eth1`, `s3-eth1` and `s4-eth1`. By the way, you can also check the counter infomations by assigning the thrift port.

Happy Hacking!

Chen, 2017.4.3