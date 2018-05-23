#!/usr/bin/env bash -ex

#================================
# mac os script
#================================
#nginx test config start
sudo /usr/local/nginx/sbin/nginx -t -c /Users/xiepeng/Documents/mac_script/nginx/nginx_base.conf

#nginx stop

#nginx restart
sudo /usr/local/nginx/sbin/nginx -s reload
