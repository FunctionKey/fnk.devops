# Update system

# Install docker runtime
sudo apt install -y docker.io

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube cluster
minikube start --vm-driver=docker