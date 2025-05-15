#!/bin/bash

 set -e

 kind create cluster --name nginx-kind --config kind-cluster.yaml

 kubectl create serviceaccount default || true
 
 echo "Deploying nginx Pod and Service"
 kubectl apply -f nginx-pod.yaml
 kubectl apply -f nginx-service.yaml

 kubectl wait --for=condition=Ready pod/nginx --timeout=60s

 kubectl get nodes
 kubectl get pods
 kubectl describe pod nginx


 echo "Acces Nginx at:"

 echo " http://localhost:6080 (hostPort direct)"
 echo " http://localhost:30060 (NodePort Service)"

