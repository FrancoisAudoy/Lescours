#!/usr/bin/python3

import socket
import select
import threading

sock_udp = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM,0)
sock_udp.bind(('',7777))

while(True):
    reception_data, reception_addr = sock_udp.recvfrom(1500)
    sock_udp.sendto(reception_data, reception_addr)
