# Install docker before installing Kubernetes

# Install dependencies on each ubuntu system
sudo apt install -y apt-transport-https curl

# Add Kubernetes GPG key on each ubuntu system
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# expect OK from terminal

# Add Kubernetes repository on each ubuntu system
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Actualy install kubernetes
sudo apt install -y kubeadm kubelet kubectl

# Verify the version of each of the tools on each machine.
sudo kubeadm version && kubelet --version && kubectl version