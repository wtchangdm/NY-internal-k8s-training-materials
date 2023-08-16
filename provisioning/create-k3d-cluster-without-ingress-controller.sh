#!/bin/bash

read -rp "This will teardown current k3d cluster! Do you understand the risk? 😑 (y/N)" answer

if [[ "$answer" == "y" ]]; then
    k3d cluster delete
    k3d cluster create -p "8081:80@loadbalancer"  --k3s-arg "--disable=traefik@server:0"
else
    echo exit.
    exit 1
fi
