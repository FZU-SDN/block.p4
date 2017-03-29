# trTCM P4

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

1.start the trTCM feature in the P4 switch:

```
cd cmd
./trTCM.sh
```

2.start xterms of h1 and h3:

```
mininet> xterm h1 h3
```

3.start iperf test:

```
on the xterm of h3:
iperf -s

on the xterm of h1:
iperf -c 10.0.0.3 -i 1 
```

4.check the packets through the trTCM counter:

```
./simple_switch --thrift-port 22222
counter_read pkt_color_counter 0
counter_read pkt_color_counter 1
counter_read pkt_color_counter 2
```

You can see a lot of pkts tagged red have been dropped by the filter table.

## Explaination

You can refer to the example [meter](https://github.com/p4lang/tutorials/tree/master/examples/meter#meter) for more informations.

Also you can refer to the RFC file: [trTCM RFC2698](https://tools.ietf.org/html/rfc2698)

Chen, 2017.3.26