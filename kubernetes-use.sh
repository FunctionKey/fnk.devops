# Verify the version of each of the tools on each machine.
sudo kubeadm version && kubelet --version && kubectl version

# Initialize kubernetes [ON MASTER]
IPADDR="10.0.0.10"  # replace ip with master-node's ip
NODENAME=$(hostname -s)

# Create config file [ON MASTER]
sudo mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
cd ~/.kube
sudo mv admin.conf config
sudo service kubelet restart

# Initialize Kubernetes [ON MASTER]
sudo kubeadm init \
    --apiserver-advertise-address=$IPADDR  \
    --apiserver-cert-extra-sans=$IPADDR  \
    --pod-network-cidr=192.168.0.0/16 \
    --node-name $NODENAME \
    #--ignore-preflight-errors Swap   # not required if disabled in kubernetes-install.sh
