#!/bin/bash

sudo systemctl stop apache2
sudo apt purge -y apache2 apache2-utils apache2-bin apache2.2-common
sudo apt autoremove -y
sudo apt autoclean

sudo rm -rf /etc/apache2 /var/www/html /var/log/apache2

echo "Stergerea fiserelor wordpress"
sudo rm -rf /var/www/html/wordpress

systemctl status apache2


