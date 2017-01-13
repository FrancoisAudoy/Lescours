#!/usr/bin/python3

import socket
import select
import threading

def f (sock_connected) :
    while(True):
        reception_data = sock_connected.recv(1500)
        if not reception_data:
            break
        sock_connected.send(reception_data)
    sock_connected.close()


sock_tcp = socket.socket(socket.AF_INET6, socket.SOCK_STREAM,0)
sock_tcp.bind(('',7777))
sock_tcp.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,1)
sock_tcp.listen(1)
l = []
while(True):
    liste_socket,_ ,_ = select.select(l +[sock_tcp],[] ,[] )

    for sock in liste_socket :
        if sock == sock_tcp :
            sock , inutile = sock_tcp.accept()
            l = l+[sock]

        else :
            data = sock.recv(1500)
            if not data :
                sock.close()
                l.remove(sock)
                break
            sock.send(data)
