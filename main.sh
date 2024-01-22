#!/bin/bash

curl -sL "https://api.ipify.org"
chmod +x dnstt-server
sudo ./dnstt-server -udp :53 -priv-key ahoge.key anis.juansvpn.pro "38.54.86.205:225"
