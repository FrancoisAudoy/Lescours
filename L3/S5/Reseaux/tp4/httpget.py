#!/usr/bin/python3

import socket
import sys

liste_addr = []

liste_addr = socket.getaddrinfo(sys.argv[1],"www",0,socket.SOCK_STREAM)

sock_addr = socket.socket(liste_addr[0][0], liste_addr[0][1], liste_addr[0][2])
sock_addr.connect(liste_addr[0][4])
sock_addr.send(b"GET /\r\n\n")

reception = sock_addr.recv(2000)
print(reception)

