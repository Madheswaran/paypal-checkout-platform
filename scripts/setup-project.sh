#!/bin/bash

echo "========================================="
echo "Cleaning PayPal Checkout Repository"
echo "========================================="

###############################
# Move existing services
###############################

# Auth Service -> Merchant API
if [ -d "backend/auth-service" ]; then
    git mv backend/auth-service services/merchant-api
fi

# Payment Service
if [ -d "backend/payment-service" ]; then
    git mv backend/payment-service services/payment-service
fi

# Notification Service
if [ -d "backend/notification-service" ]; then
    git mv backend/notification-service services/notification-service
fi

###############################
# Remove duplicate empty folders
###############################

rmdir backend/account-service 2>/dev/null
rmdir backend/funding-service 2>/dev/null
rmdir backend/risk-service 2>/dev/null
rmdir backend/token-service 2>/dev/null

rmdir backend 2>/dev/null

rmdir merchant-api 2>/dev/null
rmdir checkout-api 2>/dev/null

###############################
# Move Kubernetes manifests
###############################

if [ -f "k8s/frontend/frontend-deployment.yaml" ]; then
    mv k8s/frontend/frontend-deployment.yaml \
       k8s/deployments/frontend-deployment.yaml
fi

if [ -f "k8s/frontend/frontend-service.yaml" ]; then
    mv k8s/frontend/frontend-service.yaml \
       k8s/services/frontend-service.yaml
fi

rmdir k8s/frontend 2>/dev/null

###############################
# Move setup script
###############################

if [ -f "script.sh" ]; then
    mv script.sh scripts/setup-project.sh
fi

###############################
# Create remaining service folders
###############################

mkdir -p services/token-service
mkdir -p services/account-service
mkdir -p services/funding-service
mkdir -p services/risk-service
mkdir -p services/checkout-api

echo
echo "Repository cleaned successfully."
echo

tree
