#!/bin/bash -ex

#================================
# mac os script
#================================

#nginx test config start
sudo /usr/local/nginx/sbin/nginx -t -c /Users/xiepeng/Documents/mac_script/nginx/nginx_base.conf
sudo /usr/local/nginx/sbin/nginx -c /Users/xiepeng/Documents/mac_script/nginx/nginx_base.conf


sudo /usr/local/nginx/sbin/nginx -t -c /Users/xiepeng/Documents/mac_script/nginx/nginx_xw.conf
sudo /usr/local/nginx/sbin/nginx -c /Users/xiepeng/Documents/mac_script/nginx/nginx_xw.conf
#nginx stop
ps aux|grep nginx
kill -9 pid

#nginx restart
sudo /usr/local/nginx/sbin/nginx -s reload
