## https://docs.docker.com/engine/install/ubuntu/

# Uninstall old versions
sudo apt remove docker docker-engine docker.io containerd runc

## Install using the repository
# Update the apt package index to allow apt to use a repository over HTTPS
sudo apt update
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Initialize Docker
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
# verify that docker if running
sudo docker container ls

# Use hello-world image to verify that Docker Engine is installed correctly
sudo docker run hello-world
