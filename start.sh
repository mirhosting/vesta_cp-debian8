#!/bin/bash
sed -i "s/setRedirect &/#setRedirect &/g" /etc/init.d/jelinit;
iptables -t nat --flush;
sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
echo "UseDNS no" >> /etc/ssh/sshd_config;
/etc/init.d/ssh restart;
PASSWORD=$(cat /root/pass.txt);
OLDIP=$(cat /root/oldip.txt);
NEWIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v 'P-t-P:10.' | cut -d: -f2 | awk '{ print $1}');

sed -i "s/$OLDIP/$NEWIP/g" /etc/apache2/mods-enabled/rpaf.conf;
sed -i "s/$OLDIP/$NEWIP/g" /etc/apache2/conf.d/$OLDIP.conf;
sed -i "s/$OLDIP/$NEWIP/g" /home/admin/conf/web/apache2.conf;
/etc/init.d/apache2 restart;
killall -9 nginx;
sed -i "s/$OLDIP/$NEWIP/g" /etc/nginx/conf.d/$OLDIP.conf;
sed -i "s/$OLDIP/$NEWIP/g" /home/admin/conf/web/nginx.conf;
/etc/init.d/nginx start;
