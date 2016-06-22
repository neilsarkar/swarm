#!/bin/bash

# Create three vms. Docs: https://docs.docker.com/machine/drivers/aws/
docker-machine create -d digitalocean --digitalocean-access-token=8ea2e670c065f692d07eefe51ddef6e9307b843a68e6d55d25a8787a712e97b9 do-manager1
docker-machine create -d digitalocean --digitalocean-access-token=8ea2e670c065f692d07eefe51ddef6e9307b843a68e6d55d25a8787a712e97b9 do-app1
docker-machine create -d digitalocean --digitalocean-access-token=8ea2e670c065f692d07eefe51ddef6e9307b843a68e6d55d25a8787a712e97b9 do-app2

# Create swarm from vms
docker-machine ssh do-manager1 "docker swarm init --listen-addr $(docker-machine ip do-manager1):2377"
docker-machine ssh do-app1 "docker swarm join $(docker-machine ip do-manager1):2377"
docker-machine ssh do-app2 "docker swarm join $(docker-machine ip do-manager1):2377"

# Create service from helloswarm
docker build -f ./Dockerfile.production . -t neilsarkar/helloswarm
docker push neilsarkar/helloswarm
docker-machine ssh do-manager1 "docker service create --replicas 3 --name helloswarm --publish 3000:3000/tcp neilsarkar/helloswarm"

# Inspection
docker-machine ssh do-manager1 "docker service inspect --pretty helloswarm"
docker-machine ssh do-manager1 "docker service tasks helloswarm"

# Change scale
# docker-machine ssh manager1 "docker service scale helloswarm=3"

# Teardown
# docker-machine ssh manager1 "docker service rm helloswarm"
