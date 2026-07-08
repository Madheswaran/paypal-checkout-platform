#!/bin/bash

set -e

echo "==============================================="
echo " PayPal Checkout Platform Bootstrap"
echo "==============================================="




ACR_NAME="acrpaypal$(date +%s)"
AKS_NAME="aks-paypal-dev"
SECRET_NAME="acr-secret"

echo
echo "========== Azure Login =========="
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login

echo "Available Resource Groups:"
az group list -o table
RG=$(az group list --query "[0].name" -o tsv)

echo "Using Resource Group: $RG"

echo
echo "========== Creating ACR =========="

if ! az acr show --resource-group "$RG" --name "$ACR_NAME" >/dev/null 2>&1
then
    az acr create \
        --resource-group "$RG" \
        --name "$ACR_NAME" \
        --sku Basic
	az acr list -o table
else
    echo "ACR already exists."
fi

echo
echo "========== Creating AKS =========="

if ! az aks show --resource-group "$RG" --name "$AKS_NAME" >/dev/null 2>&1
then
    az aks create \
        --resource-group "$RG" \
        --name "$AKS_NAME" \
        --node-count 1 \
        --node-vm-size Standard_D2s_v3 \
        --generate-ssh-keys
else
    echo "AKS already exists."
fi


echo
echo "========== Checking kubectl =========="

if command -v kubectl >/dev/null 2>&1; then
    echo "kubectl already installed."
    kubectl version --client
else
    echo "kubectl not found. Installing..."

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    chmod +x kubectl

    sudo mv kubectl /usr/local/bin/

    echo "kubectl installed successfully."

    kubectl version --client
fi

echo
echo "========== Getting AKS Credentials =========="

az aks get-credentials \
    --resource-group "$RG" \
    --name "$AKS_NAME" \
    --overwrite-existing

echo
echo "========== Enabling ACR Admin =========="

az acr update \
    --name "$ACR_NAME" \
    --admin-enabled true

echo
echo "========== Getting ACR Credentials =========="

ACR_USERNAME=$(az acr credential show \
    --name "$ACR_NAME" \
    --query username \
    -o tsv)

ACR_PASSWORD=$(az acr credential show \
    --name "$ACR_NAME" \
    --query "passwords[0].value" \
    -o tsv)

echo "ACR Username: $ACR_USERNAME"

echo
echo "========== Creating Image Pull Secret =========="

kubectl delete secret $SECRET_NAME --ignore-not-found

kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=$ACR_NAME.azurecr.io \
    --docker-username=$ACR_NAME \
    --docker-password="$ACR_PASSWORD"


kubectl get pods
kubectl get svc

echo
echo "Bootstrap completed successfully."
