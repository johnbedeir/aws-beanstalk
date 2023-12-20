#!/bin/bash

# create the cluster
echo "--------------------Creating RDS--------------------"
echo "--------------------Creating EB--------------------"
cd terraform && \ 
terraform init 
terraform apply -auto-approve
cd ..

# Deploy App
echo "--------------------Deploy App--------------------"
cd todo-app && \
eb deploy

# Open App
echo "--------------------Open App--------------------"
eb open