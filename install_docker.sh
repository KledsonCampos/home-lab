#!/bin/bash

# Script para instalar o Docker no Ubuntu (baseado na documentação oficial)

# Variável para o URL do script de instalação do Docker
DOCKER_INSTALL_SCRIPT="https://get.docker.com"

# Verificar se o usuário é root
if [[ $EUID -ne 0 ]]; then
  echo "Este script deve ser executado como root.  Tente usar 'sudo ./install_docker.sh'"
  exit 1
fi

# Atualizar a lista de pacotes
apt-get update

# Instalar os pacotes necessários
apt-get install -y apt-transport-https ca-certificates curl gnupg

# Adicionar o repositório do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Adicionar o repositório do Docker à lista de fontes
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

# Atualizar a lista de pacotes novamente
apt-get update

# Instalar o Docker
apt-get install -y docker-ce docker-ce-cli containerd.io

# Adicionar o usuário atual ao grupo docker
adduser $USER docker
usermod -aG docker $USER

# Informar ao usuário para reiniciar a sessão
echo "Instalação do Docker concluída!"
