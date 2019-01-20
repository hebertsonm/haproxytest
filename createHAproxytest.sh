#!/bin/bash
sudo yum install -y -q yum-utils device-mapper-persistent-data lvm2 wget curl && \
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
sudo yum -y -q install docker-ce && \
sudo systemctl enable docker.service && \
sudo systemctl start docker.service
mkdir vanhack-docker
cd vanhack-docker/
wget https://raw.githubusercontent.com/hebertsonm/haproxytest/master/Dockerfile
wget https://raw.githubusercontent.com/hebertsonm/haproxytest/master/haproxy.cfg
sudo docker build . -t haproxy1
sudo docker network create vanhack-vnet --subnet=172.18.0.0/16
sudo docker run -d --name nginx1 --network vanhack-vnet nginx
sudo docker run -d --name nginx2 --network vanhack-vnet nginx:1.14
sudo docker run -d --name haproxy --network vanhack-vnet haproxy1

for (( count=0; count<5;count++))
do
        curl -i 172.18.0.4 | grep Server
        echo
        echo
done
