# block.p4

Fuzhou University SDN Lab | P4

This repo is used to present the common function blocks in l2 switch that writed in P4.
We create the environment to test these blocks with mininet simulation tools.

## TODO

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

## SUPPORT FEATURES

0.features in `p4src`

1.port security

2.icmp security

3.udp flooding

4.port mirroring

5.resubmit

6.multicast NAT

7.trTCM

8.ECMP

9.TCP SYN/FIN check

## Demo

We have created two demo in dir `Demo`, `http_icmp_udp` and `sswitch`. 

The `http_icmp_udp` is a explaination example that one switch enabled the http security feature and another switch enabled both the icmp and udp security. See [http_icmp_udp](https://github.com/Emil-501/block.p4/tree/master/Demo/http_icmp_udp). 

The `sswitch` united all the blocks in one P4 switch pipeline, see [sswitch](https://github.com/Emil-501/block.p4/tree/master/Demo/sswitch) for more informations. 

The `DDoS` showed that how we defense the SYN/FIN/UDP DDoS attack with trTCM and TCP check. See [DDoS](https://github.com/Emil-501/block.p4/tree/master/Demo/DDoS).

## Tree

```
.
├── blocks
│   ├── ecmp
│   │   ├── cmd
│   │   │   ├── ecmp.sh
│   │   │   ├── s1.txt
│   │   │   └── simple_switch_CLI
│   │   ├── p4src
│   │   │   ├── includes
│   │   │   │   ├── ecmp.p4
│   │   │   │   ├── header.p4
│   │   │   │   └── parser.p4
│   │   │   └── switch.p4
│   │   ├── README.md
│   │   └── send.py
│   ├── icmp_security
│   │   ├── cmd
│   │   │   ├── icmp_sec.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   └── simple_switch_CLI
│   │   └── p4src
│   │       ├── includes
│   │       │   ├── header.p4
│   │       │   ├── icmp.p4
│   │       │   └── parser.p4
│   │       └── switch.p4
│   ├── multicast_NAT
│   │   ├── cmd
│   │   │   ├── nat.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   └── simple_switch_CLI
│   │   ├── p4src
│   │   │   ├── includes
│   │   │   │   ├── header.p4
│   │   │   │   ├── nat.p4
│   │   │   │   └── parser.p4
│   │   │   └── switch.p4
│   │   ├── README.md
│   │   ├── send.py
│   │   └── wireshark
│   │       ├── after_nat.jpg
│   │       └── sent_to_ip10.jpg
│   ├── port_mirror
│   │   ├── cmd
│   │   │   ├── pkt_mirror.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   └── simple_switch_CLI
│   │   ├── p4src
│   │   │   ├── includes
│   │   │   │   ├── header.p4
│   │   │   │   ├── parser.p4
│   │   │   │   └── port_mirror.p4
│   │   │   └── switch.p4
│   │   └── pic
│   │       └── copy_to_port2.jpg
│   ├── port_security
│   │   ├── cmd
│   │   │   ├── port_security.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   └── simple_switch_CLI
│   │   └── p4src
│   │       ├── includes
│   │       │   ├── header.p4
│   │       │   ├── parser.p4
│   │       │   └── port_security.p4
│   │       └── switch.p4
│   ├── resubmit
│   │   ├── cmd
│   │   │   ├── resubmit.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   └── simple_switch_CLI
│   │   └── p4src
│   │       ├── includes
│   │       │   ├── header.p4
│   │       │   ├── parser.p4
│   │       │   └── resubmit.p4
│   │       └── switch.p4
│   ├── tcp_check
│   │   ├── tcp_check.p4
│   │   └── white_list.p4
│   ├── trTCM
│   │   ├── cmd
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   ├── simple_switch_CLI
│   │   │   └── trTCM.sh
│   │   ├── p4src
│   │   │   ├── includes
│   │   │   │   ├── header.p4
│   │   │   │   ├── parser.p4
│   │   │   │   └── trTCM.p4
│   │   │   └── switch.p4
│   │   └── README.md
│   └── udp_flood
│       ├── cmd
│       │   ├── s1.txt
│       │   ├── s2.txt
│       │   ├── simple_switch_CLI
│       │   └── udp_flood.sh
│       └── p4src
│           ├── includes
│           │   ├── header.p4
│           │   ├── parser.p4
│           │   └── udp_flood.p4
│           └── switch.p4
├── Demo
│   ├── DDoS
│   │   ├── add_entry.sh
│   │   ├── cmd
│   │   │   ├── run.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   ├── s3.txt
│   │   │   ├── s4.txt
│   │   │   └── simple_switch_CLI
│   │   ├── commands.txt
│   │   ├── env.sh
│   │   ├── mclearn
│   │   │   ├── forward
│   │   │   │   ├── s1.txt
│   │   │   │   ├── s2.txt
│   │   │   │   ├── s3.txt
│   │   │   │   └── s4.txt
│   │   │   ├── learn.sh
│   │   │   └── simple_switch_CLI
│   │   ├── p4src
│   │   │   ├── includes
│   │   │   │   ├── header.p4
│   │   │   │   ├── icmp_security.p4
│   │   │   │   ├── parser.p4
│   │   │   │   ├── tcp_check.p4
│   │   │   │   ├── trTCM.p4
│   │   │   │   ├── udp_flood.p4
│   │   │   │   └── white_list.p4
│   │   │   └── switch.p4
│   │   ├── README.md
│   │   ├── run_demo.sh
│   │   ├── send.py
│   │   ├── simple_switch_CLI
│   │   ├── topo.py
│   │   └── topo.txt
│   ├── http_icmp_udp
│   │   ├── cmdv1
│   │   │   ├── run.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   ├── s3.txt
│   │   │   ├── s4.txt
│   │   │   └── simple_switch_CLI
│   │   ├── cmdv2
│   │   │   ├── run.sh
│   │   │   ├── s1.txt
│   │   │   ├── s2.txt
│   │   │   ├── s3.txt
│   │   │   ├── s4.txt
│   │   │   └── simple_switch_CLI
│   │   ├── env
│   │   │   ├── add_entry.sh
│   │   │   ├── commands.txt
│   │   │   ├── env.sh
│   │   │   ├── mclearn
│   │   │   │   ├── forward
│   │   │   │   │   ├── s1.txt
│   │   │   │   │   ├── s2.txt
│   │   │   │   │   ├── s3.txt
│   │   │   │   │   └── s4.txt
│   │   │   │   ├── learn.sh
│   │   │   │   └── simple_switch_CLI
│   │   │   ├── p4src
│   │   │   │   ├── includes
│   │   │   │   │   ├── easy_http_sec.p4
│   │   │   │   │   ├── header.p4
│   │   │   │   │   ├── icmp.p4
│   │   │   │   │   ├── parser.p4
│   │   │   │   │   └── udp_flood.p4
│   │   │   │   └── switch.p4
│   │   │   ├── run_demo.sh
│   │   │   ├── send.py
│   │   │   ├── simple_switch_CLI
│   │   │   ├── switch.json
│   │   │   ├── topo.py
│   │   │   └── topo.txt
│   │   ├── README.md
│   │   └── tcp_pkt_validate.jpg
│   └── sswitch
│       ├── add_entry.sh
│       ├── cmd
│       │   ├── actions.txt
│       │   ├── run.sh
│       │   ├── set_default.txt
│       │   └── simple_switch_CLI
│       ├── commands.txt
│       ├── env.sh
│       ├── mclearn
│       │   ├── mclearn_cmd_s1.txt
│       │   ├── mc_learn.sh
│       │   └── simple_switch_CLI
│       ├── p4src
│       │   ├── blocks
│       │   │   ├── icmp.p4
│       │   │   ├── port_mirror.p4
│       │   │   ├── port_security.p4
│       │   │   ├── resubmit.p4
│       │   │   ├── trTCM.p4
│       │   │   └── udp_flood.p4
│       │   ├── includes
│       │   │   ├── header.p4
│       │   │   └── parser.p4
│       │   └── switch.p4
│       ├── read
│       │   ├── green.txt
│       │   ├── icmp.txt
│       │   ├── port_mirror.txt
│       │   ├── read.py
│       │   ├── red.txt
│       │   ├── simple_switch_CLI
│       │   └── yellow.txt
│       ├── README.md
│       ├── run_demo.sh
│       ├── simple_switch_CLI
│       ├── switch.json
│       ├── topo.py
│       └── topo.txt
├── env
│   ├── add_entry.sh
│   ├── commands.txt
│   ├── env.sh
│   ├── mclearn
│   │   ├── mclearn_cmd_s1.txt
│   │   ├── mclearn_cmd_s2.txt
│   │   ├── mc_learn.sh
│   │   └── simple_switch_CLI
│   ├── run_demo.sh
│   ├── runtime_CLI.py
│   ├── simple_switch_CLI
│   ├── topo.py
│   └── topo.txt
├── issue_template.md
├── LICENSE
├── p4src
│   ├── acl.p4
│   ├── egress_filter.p4
│   ├── fabric.p4
│   ├── hashes.p4
│   ├── includes
│   │   ├── cpu_reason_codes.h
│   │   ├── defines.p4
│   │   ├── drop_reason_codes.h
│   │   ├── headers.p4
│   │   ├── intrinsic.p4
│   │   ├── p4features.h
│   │   ├── p4_table_sizes.h
│   │   └── parser.p4
│   ├── int_transit.p4
│   ├── ipv4.p4
│   ├── ipv6.p4
│   ├── l2.p4
│   ├── l3.p4
│   ├── LICENSE
│   ├── meter.p4
│   ├── mirror.p4
│   ├── multicast.p4
│   ├── nat.p4
│   ├── nexthop.p4
│   ├── openflow.p4
│   ├── p4_files.am
│   ├── port.p4
│   ├── qos.p4
│   ├── README.md
│   ├── rewrite.p4
│   ├── security.p4
│   ├── sflow.p4
│   ├── switch_config.p4
│   ├── switch.p4
│   └── tunnel.p4
├── README.md
└── templates
    ├── header.p4
    ├── parser.p4
    └── switch.p4
```
