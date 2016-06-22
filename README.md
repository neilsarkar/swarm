This is an experiment with Docker Swarm to get a proof of concept of an EC2 or Digital Ocean backed app server swarm.

Goals of Project:

* <del>dev environment reloads server on file save</del>
* <del>local swarm of apps with round robin load balancer</del>
* local database that app swarm connects to
* <del>prod ec2 cluster</del>
* <del>automatically rebalance when a node goes offline is killed</del>
* <del>add node to preferred running size</del>
* <del>deploy new code with no downtime</del>
* jenkins
  * run tests
  * auto-deploy container

Setup:

To use Digital Ocean:
* Set `DO_TOKEN` environment variable from digital ocean API admin.

To use AWS:
* Download the AWS CLI and run `aws configure`
