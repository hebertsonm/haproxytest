# HAproxy test

This is about creating and testing HAproxy (v1.9). It sets up an evironment with two Nginx containers (one on 1.14 and other in the latest version) in a same virtual network with the HAproxy, then it runs curl to get the version of both Nginx servers.

## Using the script

The createHAproxy.sh script installs the whole tool set needed in this lab on a Centos 7.5. 

`./createHAproxy.sh`

## Manually

1. Copy the files `Dockerfile` and `haproxy.cfg` to a folder in a docker server, and build the image.

`sudo docker build . -t haproxy1`

2. Create the network and containers.

````
sudo docker network create vanhack-vnet --subnet=172.18.0.0/16
sudo docker run -d --name nginx1 --network vanhack-vnet nginx
sudo docker run -d --name nginx2 --network vanhack-vnet nginx:1.14
sudo docker run -d --name haproxy --network vanhack-vnet haproxy1
````

3. Test the load balacing by executing the curl command many times

`curl -i 172.18.0.4 | grep Server`
