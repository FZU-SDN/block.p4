# SSwitch

Single/Simple Switch

## 🕶 Support Features

- ICMP security
- port security
- port mirror
- UDP flood
- resubmit
- speed limitation(trTCM)

## 📚 Validate

First you should start the mininet and execute mac learning. Then cd to the dir `cmd`:

```
cd cmd
./run.sh
```

Then mutiple switch features have been added to the switch s1. You could validate them by confirming these things:

```
mininet> pingall
```

- h1 cannot ping to h3
- h2 cannot ping to h4

Besides, you can capture the icmp packets (`h1 to h2` or `h2 to h4`) on the port 3 with Wireshark.

You can also to read the status of mutiple counters using the script:

```
cd read
./read.py
```

## 😋 And...

Feel free to move the blocks in `p4src/blocks` to meet your target.

Chen, 2017.3.29