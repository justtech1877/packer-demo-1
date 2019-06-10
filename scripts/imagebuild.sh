#!/bin/sh


export AWS_DEFAULT_PROFILE=cr-labs-skill-up
#ARTIFACT=`packer build -machine-readable packer-demo.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=$(packer build -machine-readable packer-demo.json 2>&1 | awk '{FS=":"}{print $NF}' | grep ami\-|tail -1)
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
aws s3 cp amivar.tf s3://terraform-state-c29df1kjsadfkjb/amivar.tf
