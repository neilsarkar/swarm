#!/bin/bash

# Create three vms
docker-machine create -d virtualbox manager1
docker-machine create -d virtualbox app1
docker-machine create -d virtualbox app2

# Create swarm from vms
docker-machine ssh manager1 "docker swarm init --listen-addr $(docker-machine ip manager1):2377"
docker-machine ssh app1 "docker swarm join $(docker-machine ip manager1):2377"
docker-machine ssh app2 "docker swarm join $(docker-machine ip manager1):2377"

# Create service from helloswarm
docker build -f ./Dockerfile.production . -t neilsarkar/helloswarm
docker push neilsarkar/helloswarm
docker-machine ssh manager1 "docker service create --replicas 3 --name helloswarm --publish 3000:3000/tcp neilsarkar/helloswarm"

# Inspection
docker-machine ssh manager1 "docker service inspect --pretty helloswarm"
docker-machine ssh manager1 "docker service tasks helloswarm"

# Change scale
# docker-machine ssh manager1 "docker service scale helloswarm=3"

# Teardown
# docker-machine ssh manager1 "docker service rm helloswarm"
