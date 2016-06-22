#
# dev.sh starts a single instance of the node app that auto updates on save
#

docker build . -t helloswarm
docker run --name helloswarm -d -p 3000:3000 -v /Users/neilsarkar/workspace/swarm:/src helloswarm
