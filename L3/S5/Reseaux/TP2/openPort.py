def openPort(ip) :
    paquet_TCP = TCP()
    paquet_TCP.sport=12345
    paquet_IP=IP()
    paquet_IP.dst= ip
    t= []
    for i in range(1,101) :
        paquet_TCP.dport=i
        paquet = paquet_IP/paquet_TCP
        reponse = sr1(paquet)
        if reponse.payload.flags & 4 == 0 :
            t.append("Open")
        else :
            t.append("Close")
    return t

addr_ip= "10.0.0.2"
tab_port=openPort(addr_ip)
print(tab_port)
