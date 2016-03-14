FROM debian:8
MAINTAINER admin <admin@admin.com>
RUN export DEBIAN_FRONTEND=noninteractive

RUN /etc/init.d/ssh_key_hack.sh

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install nginx php5-fpm mysql-server

EXPOSE 22 80 3306
