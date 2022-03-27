# Grab Docker image for ubuntu
sudo docker pull ubuntu

# run a Docker container named container1 using ubuntu image
sudo docker run -d -t --name container1 ubuntu

# verify that a container is running
sudo docker ps

# interract with container's terminal
sudo docker exec -it container1 bash

# grap alpine image
sudo docker pull alpine

# run another docker container
sudo docker run -d -t --name container 2 alpine

# verify container is runnig
sudo docker ps

# stop docker container
sudo docker stop container1

# verify container status
sudo docker ps

# restart container
sudo docker start container1

# verify container's resource usage
sudo docker stats