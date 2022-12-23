#!/bin/bash

echo current user $USER

echo "---------------------------------------------------------"

sudo apt update

echo "---------------------------------------------------------"

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install docker-compose

echo "---------------------------------------------------------"

# Install GIT
sudo apt install git
git --version

echo "---------------------------------------------------------"

# Install Cron
sudo apt-get install cron

echo "---------------------------------------------------------"

# Download saves
mkdir -p ./steam/valheim/saves/worlds_local ./steam/valheim/server ./steam/valheim/backups
wget -P ./steam/valheim/saves/worlds_local https://github.com/saviocfm/valheimServer/raw/main/Gameplay.fwl
wget -P ./steam/valheim/saves/worlds_local https://github.com/saviocfm/valheimServer/raw/main/Gameplay.db

echo "---------------------------------------------------------"

# Get Docker file from GIT
wget https://raw.githubusercontent.com/IgorSSK/GameCenter.DServers/main/servers/valheim/docker-compose.yml

echo "---------------------------------------------------------"

# Up Container
sudo docker-compose up