#!/bin/bash

echo "Creating .gitkeep files..."

###############################
# Top-level Services
###############################

touch checkout-service/.gitkeep 2>/dev/null
touch merchant-service/.gitkeep 2>/dev/null

###############################
# Backend Services
###############################

touch services/token-service/.gitkeep
touch services/account-service/.gitkeep
touch services/funding-service/.gitkeep
touch services/risk-service/.gitkeep

###############################
# Kubernetes
###############################

touch k8s/namespace/.gitkeep
touch k8s/configmaps/.gitkeep
touch k8s/secrets/.gitkeep
touch k8s/deployments/.gitkeep
touch k8s/services/.gitkeep
touch k8s/ingress/.gitkeep
touch k8s/hpa/.gitkeep
touch k8s/rbac/.gitkeep

###############################
# Helm
###############################

touch helm/paypal-checkout/.gitkeep

###############################
# Terraform
###############################

touch terraform/modules/.gitkeep
touch terraform/environments/dev/.gitkeep
touch terraform/environments/prod/.gitkeep

###############################
# Monitoring
###############################

touch monitoring/prometheus/.gitkeep
touch monitoring/grafana/.gitkeep

###############################
# Documentation
###############################

touch docs/.gitkeep

###############################
# Scripts
###############################

touch scripts/.gitkeep

echo
echo ".gitkeep files created."
