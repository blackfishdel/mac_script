#!/bin/bash -ex

#================================
# mac os script
#================================

#sudo port install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel


mkdir -p /opt/local/share/src

cd /opt/local/share/src
curl -O http://nginx.org/download/nginx-1.14.0.tar.gz

mkdir -p /opt/local/share/nginx
tar -zxvf nginx-1.14.0.tar.gz -C /opt/local/share/nginx

cd /opt/local/share/nginx/nginx-1.14.0
./configure && make && make install
