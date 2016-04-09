#!/bin/bash
sleep 10;
iptables -t nat --flush;
OLDIP=$(cat /root/oldip.txt);
NEWIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v 'P-t-P:10.' | cut -d: -f2 | awk '{ print $1}');

sed -i "s/$OLDIP/$NEWIP/g" /etc/apache2/mods-enabled/rpaf.conf;
sed -i "s/$OLDIP/$NEWIP/g" /etc/apache2/conf.d/$OLDIP.conf;
/etc/init.d/apache2 restart;
sed -i "s/$OLDIP/$NEWIP/g" /etc/nginx/conf.d/$OLDIP.conf;
sed -i "s/$OLDIP/$NEWIP/g" /home/admin/conf/web/nginx.conf;
/etc/init.d/nginx restart;
