#!bin/bash

hostname -I
manager_ip="192.168.56.10"
docker swarm init --advertise-addr "$manager_ip"
swarm_token=$(docker swarm join-token -q worker)

#Ne logam pe fiecare worker avand editat .ssh/config
echo "Pe fiecare worker,ne conectam cu shh vm1/vm2"
echo "docker swarm join --token$swarm_token $manager_ip:2377"


read -p


docker node ls

docker network create --driver overlay wordpress-network

docker service create --name wp-mysql --network wordpress-network \
   -e MYSQL_ROOT_PASSWORD=rtpass \
   -e MYSQL_DATABASE=wordpress \
   -e MYSQL_USER=wpuser \
   -e MYSQL_PASSWORD=wppass \
   mysql:5.7

docker service create --name wordpress --network wordpress-network \
  -p 4020:80 \
  -e WORDPRESS_DB_HOST=WP-MYSQL:3306 \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppass \
  -e WORDPRESS_DB_NAME=wordpress \
  wordpress:latest

docker service ps wordpress
echo "Wordpress este accesibil la,http://$manager_ip:4020"

