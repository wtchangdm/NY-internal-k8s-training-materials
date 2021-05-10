#!/bin/bash

set -e

function checkService () {
  local SERVICE=$1
  if [[ $(systemctl is-active --quiet "$SERVICE") -eq "0" ]]; then
    echo "$SERVICE is running."
  else
    echo "$SERVICE is unavailable."
  fi
}

function removeUnneededOCIImages () {
  echo "Remove unneeded OCI images..."
  docker images -q | xargs docker rmi > /dev/null 2>&1
}

function installDeps () {
  echo "Installing K3d..."
  curl -sSL https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash > /dev/null 2>&1

  echo "Installing kubectl..."
  curl -sSLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

function addCLIShortCut () {
  source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
  echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
  echo "alias k=kubectl" >> ~/.bashrc
  echo "complete -F __start_kubectl k" >> ~/.bashrc
  alias k=kubectl
  complete -F __start_kubectl k
}

function createK3dCluster () {
  echo "Creating k3d cluster..."
  k3d cluster create -p "8081:80@loadbalancer"
}

./extend-cloud9-ebs.sh 30
checkService docker
removeUnneededOCIImages
installDeps
addCLIShortCut
createK3dCluster
echo "✨ Done!"
