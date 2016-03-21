FROM debian:8
MAINTAINER admin <admin@admin.com>
RUN export DEBIAN_FRONTEND=noninteractive

RUN date > /root/date.txt

EXPOSE 22 80 3306
