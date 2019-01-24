#!/bin/bash
# author: Mark Salatino
read -p "input your vps ip:" ip
sed  "s/_ip_/$ip/" ./tpl/ca.txt > ca.txt
sed  "s/_ip_/$ip/" ./tpl/server.txt > server.txt
mkdir client server
certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.txt --outfile ./client/ca-cert.pem
certtool --generate-privkey --outfile ./server/server-key.pem
certtool --generate-certificate --load-privkey ./server/server-key.pem --load-ca-certificate ./client/ca-cert.pem --load-ca-privkey ca-key.pem --template server.txt --outfile ./server/server-cert.pem
rm ca-key.pem ca.txt server.txt