FROM ubuntu:18.04
LABEL maintainer="Peter Pakos <peter@pakos.uk>"
LABEL description="Dockerised UniFi Network Controller (Ubuntu 20.04)"

ARG DEBIAN_FRONTEND=noninteractive

ARG USER=admin
ARG UID=1024
ARG GID=100
ARG UNIFI_VERSION=6.1.71
ARG UNIFI_URL=https://dl.ubnt.com/unifi/$UNIFI_VERSION/UniFi.unix.zip
ARG UNIFI_DIR=/UniFi

ADD $UNIFI_URL /tmp/

RUN useradd -m -u $UID -g $GID $USER

RUN apt-get update && apt-get -y install \
    gnupg2 \
    openjdk-8-jdk \
    readline-common \
    unzip \
 && unzip /tmp/UniFi.unix.zip -d / \
 && mkdir -p $UNIFI_DIR/data $UNIFI_DIR/logs $UNIFI_DIR/run \
 && chown -R $USER:$GID $UNIFI_DIR

# MongoDB
ADD https://www.mongodb.org/static/pgp/server-3.6.asc /tmp/
RUN cat /tmp/server-3.6.asc | apt-key add - \
 && echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/3.6 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.6.list \
 && apt-get update && apt-get -y install mongodb-org \
 && rm -rf /tmp/*

EXPOSE 3478/udp 6789 8080 8443 8843 8880 10001/udp

USER $USER
WORKDIR $UNIFI_DIR

CMD ["java", "-jar", "lib/ace.jar", "start"]
