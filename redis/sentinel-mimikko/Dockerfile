FROM registry.docker-cn.com/library/redis:3-alpine

MAINTAINER del xie <blackfishdel@gmail.com>

EXPOSE 26379

ADD sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf

#====================================================
#默认配置
#监听服务个数 2个
ENV SENTINEL_QUORUM 2
#监听关机服务 30秒
ENV SENTINEL_DOWN_AFTER 30000
#监听故障转移 180秒
ENV SENTINEL_FAILOVER 180000
#====================================================

COPY sentinel-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/sentinel-entrypoint.sh

#指定服务容器启动后执行的入口文件
ENTRYPOINT ["sentinel-entrypoint.sh"]
