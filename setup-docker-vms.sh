#!bin/bash


 echo "Ce vrei sa configurezi?"
 echo "1) VM1 - mysql"
 echo "2) VM2 - wordpress"
 read -p "Alege optiunea (1 sau 2): " optiune

 if [ "$optiune" == "1" ]; then
     echo "Configurare VM1 - mysql"

     sudo apt update
     sudo apt install -y docker.io

     sudo systemctl start docker
     sudo systemctl enable docker

    ip_vm1=$(hostname -I | awk '{print $1}')
    echo "Ip-ul detectat automat pe VM1 este :$ip_vm1"

    docker run -d --name mysql-container \
      -e MYSQL_ROOT_PASSWORD=rtpass \
      -e MYSQL_DATABASE=wordpress \
      -e MYSQL_USER=wpuser \
      -e MYSQL_PASSWORD=parola \
      -p 4000:3306 \
      mysql:5.7

   echo "Mysql ruleaza pe ip-ul $ip_vm1:4000"

 elif [ "$optiune" == "2" ]; then
     echo "Configurare VM2 - Wordpress"

     sudo apt update 
     sudo apt install -y docker.io lynx

     sudo systemctl start docker 
     sudo systemctl enable docker 

     ip_vm2=$(hostname -I | awk '{print $1}')
     echo "Ip-ul detectat automat pe VM2 este : $ip_vm2"

     read -p "Introduceti ip-ul vm1: " ip_vm1

     docker run -d --name wordpress-container \
       -e WORDPRESS_DB_HOST=${ip_vm1}:4000 \
       -e WORDPRESS_DB_USER=wpuser \
       -e WORDPRESS_DB_PASSWORD=parola \
       -e WORDPRESS_DB_NAME=wordpress \
       -p 6080:80
      wordpress:latest

      lynx http://ip_vm2:6080

 else 
    echo " Optiune invalida.Alege 1 sau 2"
 fi
