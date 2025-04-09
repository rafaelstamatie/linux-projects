
#!/bin/bash


docker network create wp-network 2>/dev/null


docker run --name wp-mysql --network wp-network \
   -e MYSQL_ROOT_PASSWORD=rtpassword \
   -e MYSQL_DATABASE=wordpress \
   -e MYSQL_USER=wpuser \
   -e MYSQL_PASSWORD=wppass \
   -d mysql:5.7

echo "Waiting for mysql"
sleep 25


docker run --name wordpress --network wp-network \
   -p 4020:80 \
   -e WORDPRESS_DB_HOST=wp-mysql:3306 \
   -e WORDPRESS_DB_USER=wpuser \
   -e WORDPRESS_DB_PASSWORD=wppass \
   -e WORDPRESS_DB_NAME=wordpress \
   -d wordpress

