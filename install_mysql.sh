#!/bin/bash
echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.6" >> /etc/apt/sources.list;
echo "deb-src http://repo.mysql.com/apt/debian/ jessie mysql-5.6" >>  /etc/apt/sources.list;
apt-get -y update;
#yes | apt-get install mysql-server-5.6 mysql-client-5.6 mysql-client-core-5.6;
