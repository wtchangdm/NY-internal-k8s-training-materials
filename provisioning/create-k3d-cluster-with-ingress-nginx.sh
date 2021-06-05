#!/bin/bash

read -rp "This will teardown current k3d cluster! Do you understand the risk? 😑 (y/N)" answer

if [[ "$answer" == "y" ]]; then
    k3d cluster delete
    k3d cluster create -p "8081:80@loadbalancer" --k3s-server-arg --disable=traefik --k3s-server-arg --disable=metrics-server
    curl "https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3" | bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace \
            --set "controller.metrics.enabled=true" \
            --set "controller.metrics.serviceMonitor.enabled=true" \
            --set "controller.dnsPolicy=ClusterFirstWithHostNet" \
            --set "controller.kind=DaemonSet"
else
    echo exit.
    exit 1
fi
