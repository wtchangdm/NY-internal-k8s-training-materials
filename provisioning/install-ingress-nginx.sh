#!/bin/bash

read -rp "Install ingress-nginx? (y/N)" answer

if [[ "$answer" == "y" ]]; then
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
