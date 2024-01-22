#!/bin/bash

curl -sL "https://api.ipify.org"
git clone https://www.bamsoftware.com/git/dnstt.git
cd dnstt/dnstt-server
go build
sudo iptables -I INPUT -p udp --dport 5300 -j ACCEPT
sudo iptables -t nat -I PREROUTING -i eth0 -p udp --dport 5303 -j REDIRECT --to-ports 5300
sudo ./dnstt-server -udp :5303 -privkey-file ../../ahoge.key anis.juansvpn.pro "38.54.86.205:225"
