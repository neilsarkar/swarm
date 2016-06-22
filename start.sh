#!/bin/bash

# Run locally in dev mode
docker run --name hello -d -p 3000:3000 -v /Users/neilsarkar/workspace/swarm:/src hello

# Create three vms
docker-machine create -d virtualbox manager1
docker-machine create -d virtualbox app1
docker-machine create -d virtualbox app2

# Create swarm manager
docker-machine ssh manager1 "docker swarm init --listen-addr $(docker-machine ip manager1):2377"

docker-machine ssh app1 "docker swarm join $(docker-machine ip manager1):2377"
docker-machine ssh app2 "docker swarm join $(docker-machine ip manager1):2377"

docker-machine ssh manager1 "docker service create --replicas 3 --name helloswarm --publish 3000:3000/tcp neilsarkar/helloswarm"
docker-machine ssh manager1 "docker service inspect --pretty helloworld"
docker-machine ssh manager1 "docker service tasks helloworld"
docker-machine ssh manager1 "docker service scale helloworld=3"
docker-machine ssh manager1 "docker service rm helloworld"
