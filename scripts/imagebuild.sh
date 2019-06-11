#####!/usr/bin/env bash -e -x

pwd
id
export AWS_DEFAULT_PROFILE=cr-labs-skill-up
#AMI_ID=$($HOME/bin/packer build -machine-readable packer-demo.json 2>&1 | awk '{FS=":"}{print $NF}' | grep ami\-|tail -1)
#ARTIFACT=`$HOME/bin/packer build -machine-readable packer-demo.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`   #### working one
ARTIFACT=`/usr/local/bin/packer build -machine-readable packer-demo.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
aws s3 cp amivar.tf s3://terraform-state-c29df1kjsadfkjb/amivar.tf
