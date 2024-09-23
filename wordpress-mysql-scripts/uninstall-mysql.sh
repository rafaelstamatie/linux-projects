#!/bin/bash


sudo systemctl stop mysql

sudo apt purge mysql-server mysql-client mysql-common -y


sudo rm -rf /etc/mysql /var/lib/mysql
sudo apt autoremove -y
sudo apt autoclean
sudo systemctl status mysql
echo "Mysql a fost dezinstalat!"
