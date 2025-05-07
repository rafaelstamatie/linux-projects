
#!/bin/bash

manager_ip=$(hostname -I | awk '{print $1}')


docker swarm init --advertise-addr "$manager_ip"


swarm_token=$(docker swarm join-token -q worker)

# SSH into each worker node(ssh vm1/vm2 if .ssh/config is set up)
echo "docker swarm join --token$swarm_token $manager_ip:2377"
read -p "Press enter after all workers have joined the swarm."


docker node ls

docker network create --driver overlay wordpress-network

docker service create --name wp-mysql --network wordpress-network \
   -e MYSQL_ROOT_PASSWORD=rtpass \
   -e MYSQL_DATABASE=wordpress \
   -e MYSQL_USER=wpuser \
   -e MYSQL_PASSWORD=wppass \
   mysql:5.7


docker service create --name wordpress  --network wordpress-network \
  -p 4020:80 \
  -e WORDPRESS_DB_HOST=wp:3306 \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppass \
  -e WORDPRESS_DB_NAME=wordpress \
  wordpress:latest

docker service ps wordpress
echo "Wordpress is available at http://$manager_ip:4020"

