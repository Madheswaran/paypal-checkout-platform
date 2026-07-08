docker build \
    -t frontend:v1 \
    -f frontend/Dockerfile \
    frontend

docker build \
    -t merchant-service:v1 \
    -f merchant-api/Dockerfile \
    merchant-api

docker build \
    -t checkout-service:v1 \
    -f checkout-api/Dockerfile \
    checkout-api

docker build \
    -t notification-service:v1 \
    -f services/notification-service/Dockerfile \
    services/notification-service

docker build \
    -t payment-service:v1 \
    -f services/payment-service/Dockerfile \
    services/payment-service

docker build \
    -t token-service:v1 \
    -f services/token-service/Dockerfile \
    services/token-service
