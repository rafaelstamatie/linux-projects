#!/bin/bash


 echo "What do you want to configure?"
 echo "1) Mysql"
 echo "2) Wordpress"
 read option

 if [ "$option" = "1" ]; then
     echo "Setting up Mysql"

    ip_vm_mysql=$(hostname -I | awk '{print $1}')

    docker run -d --name mysql-container \
      -e MYSQL_ROOT_PASSWORD=rtpass \
      -e MYSQL_DATABASE=wordpress \
      -e MYSQL_USER=wpuser \
      -e MYSQL_PASSWORD=password \
      -p 4000:3306 \
      mysql:5.7

   echo "Mysql running at $ip_vm_mysql:4000"

 elif [ "$option" = "2" ]; then
     echo "Setting up VM - Wordpress"
     
     read -p "Enter the Mysql-Vm-Ip): " ip_vm_mysql
     if [ -z "$ip_vm_mysql" ];then
	     echo "ERROR: You must specify the mysql_vm_ip."
	 exit 1
     fi


     ip_vm_wp=$(hostname -I | awk '{print $1}')

      docker run --name wordpress-container \
       --restart unless-stopped \
       -e WORDPRESS_DB_HOST=${ip_vm_mysql}:4000 \
       -e WORDPRESS_DB_USER=wpuser \
       -e WORDPRESS_DB_PASSWORD=password \
       -e WORDPRESS_DB_NAME=wordpress \
       -p 6080:80 \
       -d wordpress



    echo "Wordpress is running $ip_vm_wp:6080 and connected to Mysql $ip_vm_mysql:4000"

      # lynx http://$ip_vm_wp:6080 or lynx http://$ip_vm_wp:80


 else 
    echo "Invalid option.Please choose 1 or 2!"
 fi
