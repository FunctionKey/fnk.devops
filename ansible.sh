# Install Ansible
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

# Configure
/etc/ansible/hosts
"[k8s-cluster]

192.168.4.20
192.168.4.21
192.168.4.22

[k8s-cluster:vars]

ansible_user=sam
ansible_password=P@assword"

/etc/ansible/ansible.cfg
# uncomment SSH key