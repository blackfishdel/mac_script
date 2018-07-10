#!/bin/bash

set -e

TAG=${1:-"latest"}

echo "Building redis-master"
docker build -t registry.int.mimikko.cn/redis-master:$TAG ./
