#!/bin/bash

docker run --name hello -d -p 3000:3000 -v /Users/neilsarkar/workspace/swarm:/src hello
