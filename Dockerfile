FROM centos:centos7
MAINTAINER Andry Kondratiev andry.kondratiev@gmail.com

RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y iproute python-setuptools hostname inotify-tools yum-utils which jq less && \

  easy_install supervisor

RUN yum localinstall -y http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum install -y nginx
RUN yum clean all

ADD files /

EXPOSE 80/tcp 443/tcp

VOLUME ["/data", "/var/www", "/var/log/nginx", "/etc/nginx"]

ENTRYPOINT ["/config/bootstrap.sh"]
