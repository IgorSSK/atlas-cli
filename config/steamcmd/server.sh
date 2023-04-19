#!/bin/sh 
export templdpath=$LD_LIBRARY_PATH  
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH  
export SteamAppID=892970

echo "Starting server PRESS CTRL-C to exit"  
./valheim_server.x86_64 -name "[GameCenter] Valheim-1" -port 2456 -nographics -batchmode -world "Gameplay" -password "gameplay" -public 1 -crossplay
export LD_LIBRARY_PATH=$templdpath