#!/bin/bash
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$STEAM_APP_DIR/valheim/linux64:$LD_LIBRARY_PATH
export SteamAppId=$APP_ID

echo "Starting server PRESS CTRL-C to exit"

echo "Server Name: ${SERVER} | World ${WORLD}"

cd $STEAM_APP_DIR/valheim

"./valheim_server.x86_64" -batchmode -nographics -name "${SERVER}" -port "${SERVER_PORT}" -world "${WORLD}" -password "${SECRET}" -public "1" -savedir "${SAVE_DIR}" -crossplay

export LD_LIBRARY_PATH=$templdpath