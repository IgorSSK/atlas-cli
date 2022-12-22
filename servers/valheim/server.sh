#!/bin/bash

echo current user $USER

echo ---------------------------------------------------------

apt update

echo ---------------------------------------------------------

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install docker-compose

echo ---------------------------------------------------------

# Install GIT
apt install git
git --version

echo ---------------------------------------------------------

# Install Cron
apt-get install cron

echo ---------------------------------------------------------

# Download saves
mkdir -p $HOME/valheim-server/config/worlds_local $HOME/valheim-server/data
wget -P $HOME/valheim-server/config/worlds_local https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/saves/Gameplay.db
wget -P $HOME/valheim-server/config/worlds_local https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/saves/Gameplay.fwl

echo ---------------------------------------------------------

# Get Docker file from GIT
curl https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/docker-compose.yml

echo ---------------------------------------------------------

# Up Container
docker-compose up