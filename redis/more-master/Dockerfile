FROM registry.docker-cn.com/library/redis:4.0.9-alpine
#FROM registry.docker-cn.com/grokzen/redis-cluster:3.2.11

MAINTAINER del xie

RUN mkdir /redis-conf
RUN mkdir /redis-data

COPY ./conf/redis.conf /redis-conf

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 7000

ENTRYPOINT ["entrypoint.sh"]
