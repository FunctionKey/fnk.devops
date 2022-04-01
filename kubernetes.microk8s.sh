# Install MicroK8s
sudo snap install microk8s --classic
# expect "microk8s v1.17.3 from Canonical✓ installed" from terminal

# Check installation status
sudo microk8s.status --wait-ready

# Enable Add-ons
sudo microk8s.enable dns dashboard registry

# MicroK8s has it's own version of kubectl so it's ok to turn it into an alias
sudo snap alias microk8s.kubectl kubectl

# Find node's IP address
sudo kubectl get nodes -o wide

# Check services runnig
sudo kubectl get services -o wide   # '--all-namespaces' to see all services

# Install a web server on the pod
sudo kubectl create deployment nginx --image=nginx  # setting 'nginx' as the deployment name

# Get information about deployment
sudo kubectl get deployments

# The deployment created pod(s)
# Fetch information about the cluster's pods
sudo kubectl get pods   # '-o wide' to get the pos's IP address

# Test the web site connection
wget 10.1.83.10

# Scale a web server deployment on a cluster to 3
sudo kubectl scale --replicas=3 deployments/nginx

# Fetch information about the cluster's pods
sudo kubectl get pods   # '-o wide' to get the pos's IP address

# Delete cluster and remove MicroK8s
# Remove Add-ons
sudo microk8s.disable dashboard dns registry

# Remove MicroK8s
sudo snap remove microk8s
