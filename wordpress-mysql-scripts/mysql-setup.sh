#!/bin/bash


if [[ -z "$1" ]]; then
   echo "Foloseste un port pentru a rula scriptul ca si prim parametru!"
   exit 1
fi
port=$1

if [[ -z "$2" ]]; then 
    echo "Defineste numele bazei de date ca al doilea parametru!"
    exit 1
fi
db_name=$2

if [[ -z "$3" ]]; then
    echo "Defineste userul bazei de date ca si al treilea parametru!"
    exit 1
fi
db_user=$3

if [[ -z "$4" ]]; then
    echo "Defineste parola bazei de date ca si al patrulea parametru!"
    exit 1
fi
db_pass=$4

sudo apt update -y
sudo apt install mysql-server mysql-client -y

echo "Creeaza baza de date $db_name si utilizatorul $db_user"
sudo mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE $db_name;
CREATE USER '$db_user'@'%' IDENTIFIED BY '$db_pass';
GRANT ALL PRIVILEGES ON wordpress.* TO '$db_user'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

sudo sed -i "s/^port\s*=.*/port=$port/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysql.cnf


sudo systemctl restart mysql

sudo systemctl status mysql

echo "Instalarea si configurarea Mysql este gata"


