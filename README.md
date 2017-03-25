# block.p4
Fuzhou University SDN Lab | P4

This repo is used to present the common function blocks in l2 switch that writed in P4.
We create the environment to test these blocks with mininet simulation tools.

**TODO:**

First copy the dirs `p4src` and `cmd` in the block such as port security to the `env` dir. 

Then do these:

```
cd env

./run_demo.sh
./add_entry.sh

cd mclearn
./mc_learn.sh
```

Then you can start these blocks with the env.

**SUPPORT FEATURES**

0.features in `p4src`

1.port security

2.icmp security

3.udp flooding

4.port mirroring

5.resubmit

6.multicast NAT