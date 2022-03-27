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

# Execute the following commands [ON MASTER] for IPtables to see bridged traffic.
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Disable swap [ON ALL NODES]
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab