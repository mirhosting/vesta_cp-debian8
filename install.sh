#!/bin/bash
OLDIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v 'P-t-P:10.' | cut -d: -f2 | awk '{ print $1}')
echo "$OLDIP" > /root/oldip.txt;

< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8} > /root/pass.txt;
pass=$(cat /root/pass.txt);
cd /root && yes | bash vst-install.sh --nginx yes --apache yes --phpfpm no --vsftpd no  --proftpd yes --exim yes --dovecot yes --spamassassin no --clamav no  --named yes --iptables yes --fail2ban yes --mysql yes --postgresql no  --remi yes --quota no --hostname vesta.host --email admin@example.com  --password $pass;
