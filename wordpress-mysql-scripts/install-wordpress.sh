#!/bin/bash


if [[ -z "$1" ]]; then
    echo "Foloseste portul wordpress ca si prim parametru"
    exit 1
fi

wp_port=$1

if [[ -z "$2" ]]; then
     echo "Foloseste numele bazei de date ca si al doilea argument!"
     exit 1
fi

db_name=$2

if [[ -z "$3" ]]; then
    echo "Foloseste user-ul bazei de date  ca si al treilea argument"
    exit 1
fi

db_user=$3

if [[ -z "$4" ]]; then
    echo "Foloseste parola bazei de date ca si al patrulea argument"
    exit 1
fi

db_pass=$4

db_host="192.168.122.107:87"


sudo apt update 
sudo apt install -y apache2 php php-mysql libapache2-mod-php mysql-clie
sudo sed -i "s/listen 80/listen $wp_port/" /etc/apache2/ports.conf


sudo systemctl restart apache2


sudo wget -O /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz
sudo tar -xzf /tmp/latest.tar.gz -C /var/www/html/
sudo rm /tmp/latest.tar.gz

sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

cd /var/www/html/wordpress
sudo cp wp-config-sample.php wp-config.php

sudo tee wp-config.php << EOF > /dev/null
<?php
define('db_name', '$db_name');
define('db_user', '$db_user');
define('db_passowrd', '$db_pass');
define('db_host', '$db_host');

EOF
 
sudo systemctl status apache2
