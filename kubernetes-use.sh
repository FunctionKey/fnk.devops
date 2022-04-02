# Verify the version of each of the tools on each machine.
sudo kubeadm version && kubelet --version && kubectl version

# Initialize kubernetes [ON MASTER]
# Create config file [ON MASTER]
sudo mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
cd ~/.kube
sudo mv admin.conf config
sudo service kubelet restart

# 2 ways of initializing k8s. In testing fase
    # Initialize Kubernetes [ON MASTER]
    IPADDR="10.0.0.10"  # replace ip with master-node's ip
    NODENAME=$(hostname -s)
    sudo kubeadm init \
        --apiserver-advertise-address=$IPADDR  \
        --apiserver-cert-extra-sans=$IPADDR  \
        --pod-network-cidr=10.244.0.0/16 \
        --node-name $NODENAME #\
        #--ignore-preflight-errors Swap   # not required if disabled in kubernetes-install.sh


    # Expose Kubernetes API [ON MASTER]
    # Use the internal IP address of the master node in the flag --apiserver-advertise-address=
    kubeadm init \
        --pod-network-cidr=10.244.0.0/16 \
        --apiserver-advertise-address=10.0.0.4 \
        --skip-preflight-checks \
        --kubernetes-version stable-1.23
