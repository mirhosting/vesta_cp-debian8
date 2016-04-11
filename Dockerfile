FROM debian:8.4
MAINTAINER admin <evgeniy@kolesnyk.ru>
RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y autoremove apache2
RUN apt-get -y install curl

RUN cd /root && curl -O http://vestacp.com/pub/vst-install.sh
COPY install.sh /root/install.sh 
RUN chmod +x /root/install.sh
RUN /root/install.sh

RUN echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.6" >> /etc/apt/sources.list
RUN echo "deb-src http://repo.mysql.com/apt/debian/ jessie mysql-5.6" >>  /etc/apt/sources.list
RUN apt-get -y update
RUN yes | apt-get install mysql-server-5.6 mysql-client-5.6 mysql-client-core-5.6

COPY start.sh /root/start.sh 
RUN chmod +x /root/start.sh

EXPOSE 21 22 80 3306 8083

ENTRYPOINT /root/start.sh
