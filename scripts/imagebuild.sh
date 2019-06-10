#!/bin/sh

set -v

export AWS_DEFAULT_PROFILE=cr-labs-skill-up
ARTIFACT=`packer build -var 'profile=cr-labs-skill-up' -machine-readable packer-demo.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
aws s3 cp amivar.tf s3://terraform-state-c29df1kjsadfkjb/amivar.tf --profile cr-labs-skill-up