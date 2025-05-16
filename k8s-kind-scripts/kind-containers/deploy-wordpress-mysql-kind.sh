
#!/bin/bash


 kind create cluster --name kind

 kubectl apply -f mysql.yaml

 kubectl apply -f wordpress.yaml

 wordpress_host=$(hostname -I | awk '{print $1}')


 echo "Wordpress is live at http://$wordpress_host:30080"
 echo "Check services with kubectl get svc"

