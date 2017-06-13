#!/bin/bash
sed -i "s/setRedirect &/#setRedirect &/g" /etc/init.d/jelinit;
iptables -t nat --flush;
sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
echo "UseDNS no" >> /etc/ssh/sshd_config;
/etc/init.d/ssh restart;
PASSWORD=$(cat /root/pass.txt);
OLDIP=$(cat /root/oldip.txt);
NEWIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v 'P-t-P:10.' | cut -d: -f2 | awk '{ print $1}');

killall -9 apache2;
killall -9 nginx;
cd /usr/local/vesta/data/ips && mv * $NEWIP;
cd /etc/apache2/conf.d && sed -i -- "s/172.*.*.*:80/$NEWIP:80/g" * && sed -i -- "s/172.*.*.*:8443/$NEWIP:8443/g" *;
cd /etc/nginx/conf.d && sed -i -- "s/172.*.*.*:80;/80;/g" * && sed -i -- "s/172.*.*.*:8080/$NEWIP:8080/g" *;
cd /home/admin/conf/web && sed -i -- "s/172.*.*.*:80;/80;/g" * && sed -i -- "s/172.*.*.*:8080/$NEWIP:8080/g" *;

sed -i 's/eth0/venet0/g' /usr/local/vesta/data/ips/$NEWIP;
sed -i 's/255.255.0.0/255.255.255.255/g' /usr/local/vesta/data/ips/$NEWIP;
sed -i 's/52.206.84.71//g' /usr/local/vesta/data/ips/$NEWIP;

mv /etc/apache2/conf.d/$OLDIP.conf /etc/apache2/conf.d/$NEWIP.conf
mv /etc/nginx/conf.d/$OLDIP.conf /etc/nginx/conf.d/$NEWIP.conf

/etc/init.d/apache2 start;
/etc/init.d/nginx start;
