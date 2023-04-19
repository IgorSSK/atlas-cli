FROM ubuntu:latest as build_stage

# LABEL maintainer="walentinlamonos@gmail.com"
ARG PUID=1000

ENV TZ=America/Sao_Paulo
ENV USER steam
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMDDIR "${HOMEDIR}/steamcmd"
# ENV STEAMAPPDIR "${HOMEDIR}/steam_apps"
# ENV SAVEDIR "${STEAMAPPDIR}/valheim/saves"

RUN set -x \
    # Install, update & upgrade packages
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    lib32stdc++6 libatomic1 libpulse-dev libpulse0 lib32gcc-s1          \
    ca-certificates nano curl locales                                   \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    # Create unprivileged user
    && useradd -u "${PUID}" -m "${USER}" \
    # Download SteamCMD, execute as user
    && su "${USER}" -c \
    "mkdir -p \"${STEAMCMDDIR}\" \
    && curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
    && \"./${STEAMCMDDIR}/steamcmd.sh\" +quit \
    && mkdir -p \"${HOMEDIR}/.steam/sdk32\" \
    && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${HOMEDIR}/.steam/sdk32/steamclient.so\" \
    && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
    && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\"" \
    # Symlink steamclient.so; So misconfigured dedicated servers can find it
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
    # Clean up
    && apt-get remove --purge --auto-remove -y \
    && rm -rf /var/lib/apt/lists/*

# FROM build_stage AS bullseye-root
WORKDIR ${HOMEDIR}

COPY ./cli/atlas/target/release ${HOMEDIR}/.atlas
RUN chmod a+x ${HOMEDIR}/.atlas/atlas 
# && mkdir -p ${HOMEDIR}/steam_apps/valheim/saves ${HOMEDIR}/steam_apps/valheim/logs

ENV PATH=${STEAMCMDDIR}:${HOMEDIR}/.atlas:${PATH}

# FROM bullseye-root AS bullseye
# Switch to user
USER ${USER}


# Overwrite Stopsignal for graceful server exits
STOPSIGNAL SIGINT

EXPOSE 2456/udp
EXPOSE 2457/udp
EXPOSE 2458/udp