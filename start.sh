#!/bin/bash
iptables -t nat --flush;
PASSWORD=$(cat /root/pass.txt);
OLDIP=$(cat /root/oldip.txt);
NEWIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v 'P-t-P:10.' | cut -d: -f2 | awk '{ print $1}');

echo "
<html>
 <head>
  <title>Data access</title>
 </head>
 <body>
<h1>Data access</h1>
  <p>Vesta url: https://$NEWIP:8083</p>
  <p>Login: admin</p>
  <p>Password: $PASSWORD</p>
<h1>Network configuration</h1>
  <p>Server IP: $NEWIP</p>
  <p>Mask: 255.255.255.255</p>
</body>
</html>
" > /var/www/html/index.html;

sed -i "s/$OLDIP/$NEWIP/g" /etc/apache2/mods-enabled/rpaf.conf;
sed -i "s/$OLDIP/$NEWIP/g" /etc/apache2/conf.d/$OLDIP.conf;
/etc/init.d/apache2 restart;
sed -i "s/$OLDIP/$NEWIP/g" /etc/nginx/conf.d/$OLDIP.conf;
sed -i "s/$OLDIP/$NEWIP/g" /home/admin/conf/web/nginx.conf;
/etc/init.d/nginx restart;
