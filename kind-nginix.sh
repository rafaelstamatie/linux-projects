#!/bin/bash


 if ! command -v kind &> /dev/null; then
     echo "Please install Kind!"
     exit 1
 fi


 if ! command -v kubectl &> /dev/null; then
     echo "Please install K8s!"
     exit 1
 fi

 kind create cluster --name nginx-internal


 kubectl run nginx --image=nginx --port=80


 kubectl get nodes
 kubectl get pods
 kubectl describe pod nginx


