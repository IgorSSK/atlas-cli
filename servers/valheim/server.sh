#!/bin/bash

echo current user $USER

apt update

echo \n---------------------------------------------\n

#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install docker-compose

echo \n---------------------------------------------\n

#Install GIT
apt install git
git --version

echo \n---------------------------------------------\n

#Install Cron
apt-get install cron

echo \n---------------------------------------------\n

#Download saves
mkdir -p $HOME/valheim-server/config/worlds_local $HOME/valheim-server/data
wget -P $HOME/valheim-server/config/worlds_local https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/saves/Gameplay.db
wget -P $HOME/valheim-server/config/worlds_local https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/saves/Gameplay.fwl

echo \n---------------------------------------------\n

#Get Docker file from GIT
curl https://github.com/IgorSSK/GameCenter.DServers/blob/main/servers/valheim/docker-compose.yml

echo \n---------------------------------------------\n

#Up Container
docker-compose up