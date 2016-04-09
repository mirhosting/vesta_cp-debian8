#!/bin/bash
IP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v 'P-t-P:10.' | cut -d: -f2 | awk '{ print $1}')
echo "$IP" > /root/ip.txt;
