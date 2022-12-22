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
mkdir -p $HOME/valheim-server/config/worlds_local $HOME/valheim-server/data
wget -P $HOME/valheim-server/config/worlds_local https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/saves/Gameplay.db
wget -P $HOME/valheim-server/config/worlds_local https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/saves/Gameplay.fwl

echo "---------------------------------------------------------"

# Get Docker file from GIT
wget https://raw.githubusercontent.com/IgorSSK/GameCenter.DServers/main/servers/valheim/docker-compose.yml

echo "---------------------------------------------------------"

# Up Container
sudo docker-compose up