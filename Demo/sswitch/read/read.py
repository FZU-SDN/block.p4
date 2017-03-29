#!/usr/bin/env python

import time
import os

def main():
    print 'Now reading the states of counters...'
    time.sleep(1)
    
    print 'icmp security:\n'
    print 'icmp pkts from h1(10.0.0.1)...\n'
    os.system("./simple_switch_CLI --thrift-port 22222 < icmp.txt")
    time.sleep(1)

    print 'port mirror:\n'
    print 'mirrored pkts from h1(10.0.0.1) to h2(10.0.0.2)...\n'
    os.system("./simple_switch_CLI --thrift-port 22222 < port_mirror.txt")
    time.sleep(1)

    print 'pkt color:\n'
    print '\ncolor green pkt...\n'
    os.system("./simple_switch_CLI --thrift-port 22222 < green.txt")
    print '\ncolor yellow pkt...\n'
    os.system("./simple_switch_CLI --thrift-port 22222 < yellow.txt")       
    print '\ncolor red pkt...\n'   
    os.system("./simple_switch_CLI --thrift-port 22222 < red.txt")
    time.sleep(1)

    print '\nEnd of reading.\n'
    print 'Happy Hacking!\n'

if __name__ == '__main__':
    main()
