#!/bin/bash

echo current user $USER

#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install docker-compose

#Download saves
mkdir -p $HOME/valheim-server/config/worlds_local $HOME/valheim-server/data
wget -P $HOME/valheim-server/config/worlds_local https://releases.ubuntu.com/20.04/ubuntu-20.04-desktop-amd64.iso
wget -P $HOME/valheim-server/config/worlds_local https://releases.ubuntu.com/20.04/ubuntu-20.04-desktop-amd64.iso

#Get Docker file from GIT
curl https://gist.githubusercontent.com/robzhu/a127a6bce1ea25b01d40efb57ad1c26e/raw/30a2927a901dd614a518319cfeaa63a6bd2648a4/gistfile1.txt

#Up Container
docker-compose up