#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install nginx
# apt-get update
# apt-get -y install nginx
sudo yum update -y
sudo amazon-linux-extras install -y nginx1
# sudo yum -y install nginx

# make sure nginx is started
# service nginx start
sudo systemctl start nginx