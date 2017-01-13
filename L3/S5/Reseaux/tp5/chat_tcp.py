#!/usr/bin/python3

import socket
import select
import threading

sock_tcp = socket.socket(socket.AF_INET6, socket.SOCK_STREAM,0)
sock_tcp.bind(('',7777))
sock_tcp.listen(1)

while(True):
    new_sock_accepted, inutile = sock_tcp.accept()
    while(True):
        reception_data = new_sock_accepted.recv(1500)
        if not reception_data:
            break
        new_sock_accepted.send(reception_data)
    new_sock_accepted.close()
    break
