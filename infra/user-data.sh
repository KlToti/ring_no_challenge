#!/bin/bash

# CLONE MY MOVIE-MANAGEMENT-PROJECT REPOSETORY
git clone git@github.com:KlToti/ring_no_challenge.git

### export AWS Credentials
export AWS_PROFILE="talent-academy"
export AWS_DEFAULT_REGION="eu-central-1"

# APPLY S3 BUCKET
cd ${s3 bucket file path}
terraform init
terraform plan
### it will load the terraform.tfvars and the example.tfvars file
terraform apply -var-file example.tfvars -auto-aprove
# terraform apply -var="membername=Yelizaveta"
# Environment Variable
# TF_VAR_my_instance_type="t2.4xlarge" terraform apply

# SETUP WEBSERVER


### 
ssh -i ~/.ssh/foreign ubuntu@3.68.222.184 cat local_number.txt >> foreign_number.txt
#create document with number
awk '{s+=$1} END {print s}' foreign_number.txt > sum.txt
