#!/usr/bin/env python

from scapy.all import *

def main():
	p = Ether(dst="00:00:00:00:00:03") / IP(dst="10.0.0.10") / TCP() / "aaaaaaaaa"
	hexdump(p)
	for i in xrange(100):
		sendp(p, iface="eth0")

if __name__ == '__main__':
	main()