FROM debian:8.0
MAINTAINER admin <evgeniy@kolesnyk.ru>
RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y autoremove apache2
RUN apt-get -y install curl

COPY install.sh /root/install.sh 
RUN chmod +x /root/install.sh
RUN /root/install.sh

RUN cd /root && curl -O http://vestacp.com/pub/vst-install.sh
RUN cd /root && yes | bash vst-install.sh --nginx yes --apache yes --phpfpm no --vsftpd no  --proftpd yes --exim yes --dovecot yes --spamassassin no --clamav no  --named yes --iptables yes --fail2ban yes --mysql yes --postgresql no  --remi yes --quota no --hostname vesta.host --email admin@example.com  --password lX0xaN30X1Ctfoy

COPY start.sh /root/start.sh 
RUN chmod +x /root/start.sh

EXPOSE 21 22 80 3306 8083

ENTRYPOINT /root/start.sh
