#!/usr/bin/env bash

echo "Installing mongodb"
sudo rm -f /etc/yum.repos.d/mongodb-org-4.2.repo
sudo touch /etc/yum.repos.d/mongodb-org-4.2.repo
sudo ls -lah /etc/yum.repos.d/ | grep 'mongodb*'
echo -e "[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc" | sudo tee /etc/yum.repos.d/mongodb-org-4.2.repo

sudo cat /etc/yum.repos.d/mongodb-org-4.2.repo;

sudo yum install -y mongodb-org-4.2.0 mongodb-org-server-4.2.0 mongodb-org-shell-4.2.0 mongodb-org-mongos-4.2.0 mongodb-org-tools-4.2.0

sudo sed -i "s/bindIp:\ 127.0.0.1/bindIp:\ 0.0.0.0/g" /etc/mongod.conf
sudo echo -e "exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools" >> /etc/yum.conf

sudo systemctl start mongod.service
sudo systemctl restart mongod.service