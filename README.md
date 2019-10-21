# Dockerised UniFi Network Controller (CentOS 7)

The Docker images can be found in [the public repository on Docker Hub](https://hub.docker.com/r/peterpakos/unifi-network-controller).

## Quick Start Guide
The Docker Compose setup mounts the local `./data` directory on the host to
`/opt/UniFi/data` in the container. This directory holds the Controller's
configuration, database, logs etc. You can either use an existing folder from
the previous installation or create an empty directory if you want to start
from scratch.

```
git clone https://github.com/peterpakos/unifi-network-controller.git
cd unifi-network-controller
# Drop in your data folder:
cp -a /path/to/data ./
# If you don't have a data folder and want to start fresh, simply create it:
mkdir data
```

### Docker Compose
To start the UniFi Network Controller, run:
```
docker-compose up -d
```

### Docker
Alternatively you can start the container by running:
```
docker run -d -v /path/to/data:/opt/UniFi/data peterpakos/unifi-network-controller
```
