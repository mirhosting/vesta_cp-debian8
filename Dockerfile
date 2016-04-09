FROM debian:8.0
MAINTAINER admin <evgeniy@kolesnyk.ru>
RUN export DEBIAN_FRONTEND=noninteractive

RUN ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' > /root/123;

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y autoremove apache2
RUN apt-get -y install curl

RUN cd /root && curl -O http://vestacp.com/pub/vst-install.sh
COPY install.sh /root/install.sh 
RUN chmod +x /root/install.sh
RUN /root/install.sh

COPY start.sh /root/start.sh 
RUN chmod +x /root/start.sh

EXPOSE 21 22 80 3306 8083

ENTRYPOINT /root/start.sh
