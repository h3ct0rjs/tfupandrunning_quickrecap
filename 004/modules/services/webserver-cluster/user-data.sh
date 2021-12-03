#!/bin/bash

echo "Hello from DevOps Colombia" >index.html
ip addr show eth0 | grep inet | awk '{print $2}' >>index.html
echo "${environment}" >> index.html
nohup busybox httpd -f -p ${serverport} &