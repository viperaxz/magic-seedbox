#!/bin/bash
set -e

gcloud compute scp ubuntu@magic-seedbox:/home/ubuntu/.kube/config ./kubeconfig.yaml --zone=europe-west3-a
sed -i 's/127.0.0.1/$(terraform -chdir=terraform output -raw vm_ip)/g' kubeconfig.yaml
export KUBECONFIG=$(pwd)/kubeconfig.yaml