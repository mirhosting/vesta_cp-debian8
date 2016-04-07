FROM debian:8.0
MAINTAINER admin <evgeniy@kolesnyk.ru>
RUN export DEBIAN_FRONTEND=noninteractive

RUN locale-gen en_US.utf8
RUN update-locale LANG=en_US.utf8 LC_CTYPE=en_US.utf8 LC_ALL=en_US.utf8
RUN apt-key update && apt-get update && apt-get -y upgrade
RUN apt-get -y autoremove apache2
RUN apt-get -y install curl
RUN cd /root && curl -O http://vestacp.com/pub/vst-install.sh
RUN cd /root && yes | bash vst-install.sh --nginx yes --apache yes --phpfpm no --vsftpd no  --proftpd yes --exim yes --dovecot yes --spamassassin no --clamav no  --named yes --iptables yes --fail2ban yes --mysql yes --postgresql no  --remi yes --quota no --hostname vesta.host --email admin@example.com  --password lX0xaN30X1Ctfoy

EXPOSE 21 22 80 3306
