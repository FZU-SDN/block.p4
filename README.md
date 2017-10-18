# block.p4

This repo presents the P4-based network function blocks based on "l2_switch.p4".
We create the environment to test these blocks by using mininet simulation tools.

## Requirements

- mininet;
- bmv2;
- p4c-bm.

## Supported Blocks

- 0.features in `p4src`
- 1.port security
- 2.icmp security
- 3.udp flooding
- 4.port mirroring
- 5.resubmit
- 6.multicast NAT
- 7.trTCM
- 8.ECMP
- 9.TCP SYN/FIN check

## Demo

- "http_icmp_udp": The `http_icmp_udp` is an explaination example that one switch enabled the http security feature and another switch provides both the icmp and udp security functions. See [http_icmp_udp](https://github.com/Emil-501/block.p4/tree/master/Demo/http_icmp_udp). 
- "sswitch": The `sswitch` united all the blocks in one P4 switch pipeline, see [sswitch](https://github.com/Emil-501/block.p4/tree/master/Demo/sswitch) for more informations. 
- "DDoS": The `DDoS` showed that how to simply defense the SYN/FIN/UDP DDoS attack with trTCM and TCP check. See [DDoS](https://github.com/Emil-501/block.p4/tree/master/Demo/DDoS).

## Next Steps

Our following works focus on the combination between NFV SFC and P4 language. For more details, try this repository: [OpenP4SC](https://github.com/Emil-501/OpenP4SC).

## Questions

Mail: wasdnsxchen@gmail.com
