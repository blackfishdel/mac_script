# redis-cluster

Redis集群目标

Redis集群是Redis的一个分布式实现，具有以下目标，按照设计中的重要性排序：

高性能和线性可扩展性高达1000个节点。没有代理，使用异步复制，并且没有对值执行合并操作。

可接受的写入安全程度：系统尝试（以尽力而为的方式）保留源自与大多数主节点连接的客户端的所有写入。通常会有小窗口，可能会丢失已确认的写入内容。当客户端处于少数分区时，丢失确认写入的Windows会更大。

可用性：Redis群集能够在大部分主节点可到达的分区中存活，并且每个不再可访问的主节点至少有一个可到达的从节点。此外，使用副本迁移，任何从服务器不再复制的主服务器将从多个从服务器所覆盖的主服务器接收主服务器。

本文档中描述的内容在Redis 3.0或更高版本中实现。

当满足以下条件时，奴隶开始选举：

奴隶的主人处于FAIL状态。
主人正在服务一个非零数量的插槽。
从设备复制链接与主设备断开的时间不超过给定时间，以确保升级的从设备数据合理新鲜。这次是用户可配置的。
为了被选中，奴隶的第一步是增加它的currentEpoch计数器，并请求主实例的投票。

**Redis cluster with Docker Compose**

Using Docker Compose to setup a redis cluster with sentinel.

This project is inspired by the project of [https://github.com/mdevilliers/docker-rediscluster][1]

## Prerequisite

Install [Docker][4] and [Docker Compose][3] in testing environment

If you are using Windows, please execute the following command before "git clone" to disable changing the line endings of script files into DOS format

```
git config --global core.autocrlf false
```

## Docker Compose template of Redis cluster
Â
The template defines the topology of the Redis cluster

```
master:
  image: redis:3
slave:
  image: redis:3
  command: redis-server --slaveof redis-master 6379
  links:
    - master:redis-master
sentinel:
  build: sentinel
  environment:
    - SENTINEL_DOWN_AFTER=5000
    - SENTINEL_FAILOVER=5000    
  links:
    - master:redis-master
    - slave
```

There are following services in the cluster,

* master: Redis master
* slave:  Redis slave
* sentinel: Redis sentinel


The sentinels are configured with a "mymaster" instance with the following properties -

```
sentinel monitor mymaster redis-master 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 5000
```

The details could be found in sentinel/sentinel.conf

The default values of the environment variables for Sentinel are as following

* SENTINEL_QUORUM: 2
* SENTINEL_DOWN_AFTER: 30000
* SENTINEL_FAILOVER: 180000



## Play with it

Build the sentinel Docker image

```
docker-compose build
```

Start the redis cluster

```
docker-compose up -d
```

Check the status of redis cluster

```
docker-compose ps
```

The result is

```
         Name                        Command               State          Ports        
--------------------------------------------------------------------------------------
rediscluster_master_1     docker-entrypoint.sh redis ...   Up      6379/tcp            
rediscluster_sentinel_1   docker-entrypoint.sh redis ...   Up      26379/tcp, 6379/tcp
rediscluster_slave_1      docker-entrypoint.sh redis ...   Up      6379/tcp     
```

Scale out the instance number of sentinel

```
docker-compose scale sentinel=3
```

Scale out the instance number of slaves

```
docker-compose scale slave=2
```

Check the status of redis cluster

```
docker-compose ps
```

The result is

```
         Name                        Command               State          Ports        
--------------------------------------------------------------------------------------
rediscluster_master_1     docker-entrypoint.sh redis ...   Up      6379/tcp            
rediscluster_sentinel_1   docker-entrypoint.sh redis ...   Up      26379/tcp, 6379/tcp
rediscluster_sentinel_2   docker-entrypoint.sh redis ...   Up      26379/tcp, 6379/tcp
rediscluster_sentinel_3   docker-entrypoint.sh redis ...   Up      26379/tcp, 6379/tcp
rediscluster_slave_1      docker-entrypoint.sh redis ...   Up      6379/tcp            
rediscluster_slave_2      docker-entrypoint.sh redis ...   Up      6379/tcp            
```

Execute the test scripts
```
./test.sh
```
to simulate stop and recover the Redis master. And you will see the master is switched to slave automatically.

Or, you can do the test manually to pause/unpause redis server through

```
docker pause rediscluster_master_1
docker unpause rediscluster_master_1
```
And get the sentinel infomation with following commands

```
docker exec rediscluster_sentinel_1 redis-cli -p 26379 SENTINEL get-master-addr-by-name mymaster
```

## References

[https://github.com/mdevilliers/docker-rediscluster][1]

[https://registry.hub.docker.com/u/joshula/redis-sentinel/] [2]

[1]: https://github.com/mdevilliers/docker-rediscluster
[2]: https://registry.hub.docker.com/u/joshula/redis-sentinel/
[3]: https://docs.docker.com/compose/
[4]: https://www.docker.com

## License

Apache 2.0 license

## Contributors

* Li Yi (<denverdino@gmail.com>)
* Ty Alexander (<ty.alexander@gmail.com>)
