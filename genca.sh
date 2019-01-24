#!/bin/bash
# author: Mark Salatino
read -p "enter your trojan server ip:" ip
read -p "enter your trojan server password:" pwd
sed  "s/_ip_/$ip/" ./tpl/ca.txt > ca.txt
sed  "s/_ip_/$ip/" ./tpl/server.txt > server.txt
sed  "s/_pwd_/$pwd/" ./tpl/config-server.txt > ./config/config-server.json
sed  "s/_ip_/$ip/" ./tpl/config-client.txt > ./config/config-client.json
sed -i "s/_pwd_/$pwd/" ./config/config-client.json
mkdir client server
certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.txt --outfile ./client/ca-cert.pem
certtool --generate-privkey --outfile ./server/server-key.pem
certtool --generate-certificate --load-privkey ./server/server-key.pem --load-ca-certificate ./client/ca-cert.pem --load-ca-privkey ca-key.pem --template server.txt --outfile ./server/server-cert.pem
rm ca-key.pem ca.txt server.txt