FROM centos:8
LABEL maintainer="Peter Pakos <peter@pakos.uk>"
LABEL description="Dockerised UniFi Network Controller (CentOS 8)"

ARG USER=admin
ARG UID=1024
ARG GID=100
ARG UNIFI_VERSION=6.0.45
ARG UNIFI_URL=https://dl.ubnt.com/unifi/$UNIFI_VERSION/UniFi.unix.zip
ARG UNIFI_DIR=/UniFi

ADD files/mongodb.repo /etc/yum.repos.d/
ADD $UNIFI_URL /tmp/

RUN useradd -m -u $UID -g $GID $USER \
 && yum -y install \
    glibc-langpack-en \
    java-1.8.0-openjdk \
    mongodb-org-server \
    unzip \
 && yum clean all \
 && unzip /tmp/UniFi.unix.zip -d / \
 && mkdir -p $UNIFI_DIR/data $UNIFI_DIR/logs $UNIFI_DIR/run \
 && chown -R $USER:$GID $UNIFI_DIR \
 && rm -rf /tmp/*

EXPOSE 3478/udp 6789 8080 8443 8843 8880 10001/udp

USER $USER
WORKDIR $UNIFI_DIR

CMD ["java", "-jar", "lib/ace.jar", "start"]
