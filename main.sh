#!/bin/bash

curl -sL "https://api.ipify.org"
git clone https://www.bamsoftware.com/git/dnstt.git
cd dnstt/dnstt-server
go build
sudo ./dnstt-server -udp :53 -priv-key ahoge.key anis.juansvpn.pro "38.54.86.205:225"
