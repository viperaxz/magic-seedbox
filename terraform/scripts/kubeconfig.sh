#!/bin/bash
set -e

# Get VM IP from Terraform output
VM_IP=$(terraform -chdir=../ output -raw vm_ip)

# Fetch kubeconfig
gcloud compute scp ubuntu@magic-seedbox:/etc/rancher/k3s/k3s.yaml kubeconfig.yaml \
  --zone=europe-west3-a

# Replace localhost IP with VM's public IP
sed -i "s/127.0.0.1/${VM_IP}/g" kubeconfig.yaml

# For GitHub Actions: Set output for future steps
echo "KUBECONFIG=$(pwd)/kubeconfig.yaml" >> $GITHUB_ENV