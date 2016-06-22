#!/bin/bash

# Create three vms. Docs: https://docs.docker.com/machine/drivers/aws/
docker-machine create -d amazonec2 --engine-install-url https://test.docker.com --amazonec2-region us-west-2 --amazonec2-zone a aws-manager1
docker-machine create -d amazonec2 --engine-install-url https://test.docker.com --amazonec2-region us-west-2 --amazonec2-zone a aws-app1
docker-machine create -d amazonec2 --engine-install-url https://test.docker.com --amazonec2-region us-west-2 --amazonec2-zone a aws-app2

# Create swarm from vms
docker-machine ssh aws-manager1 "docker swarm init --listen-addr $(docker-machine ip aws-manager1):2377"
docker-machine ssh aws-app1 "docker swarm join $(docker-machine ip aws-manager1):2377"
docker-machine ssh aws-app2 "docker swarm join $(docker-machine ip aws-manager1):2377"

# Create service from helloswarm
docker build -f ./Dockerfile.production . -t neilsarkar/helloswarm
docker push neilsarkar/helloswarm
docker-machine ssh aws-manager1 "docker service create --replicas 3 --name helloswarm --publish 3000:3000/tcp neilsarkar/helloswarm"

# Inspection
docker-machine ssh aws-manager1 "docker service inspect --pretty helloswarm"
docker-machine ssh aws-manager1 "docker service tasks helloswarm"

# Change scale
# docker-machine ssh manager1 "docker service scale helloswarm=3"

# Teardown
# docker-machine ssh manager1 "docker service rm helloswarm"
