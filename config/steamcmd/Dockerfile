FROM cm2network/steamcmd:latest

USER root

RUN apt-get update


RUN cd /home/steam/Steam
RUN ./steamcmd.sh +login anonymous +force_install_dir /home/steam/valheim-server +app_update 896660 validate +exit

EXPOSE 2456/udp
EXPOSE 2457/udp
EXPOSE 2458/udp

COPY ./server.sh /home/steam/valheim-server/

RUN chmod 777 /home/steam/valheim-server/server.sh

WORKDIR /home/steam/valheim-server

# ENTRYPOINT [ "./server.sh" ]



