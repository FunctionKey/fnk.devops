# Set hostname if needed
sudo hostnamectl set-hostname linux-server-01

# Configure Network settings
sudo nano /etc/netplan/*.yaml

: ' NETPLAN YAML CONFIGURATION TEMPLATE
network:
    version: 2
    renderer: networkd
    ethernets:
        enp3s0:
            addresses:
                - 10.10.10.2/24
            gateway4: 10.10.10.1
            nameservers:
                addresses: [10.10.10.1, 1.1.1.1]
    wifis:
        wlp2s0b1:
            dhcp4: no
            dhcp6: no
            addresses: [192.168.0.21/24]
            gateway4: 192.168.0.1
            nameservers:
                addresses: [192.168.0.1, 8.8.8.8]
            access-points:
                "network_ssid_name":
                    password: "**********"
'

: ' OLD FASHION
sudo nano /etc/network/interfaces

# insert the content below
auto    enp03
iface   enp03 inet static
        address 10.10.10.2
        netmask 255.255.255.0
        gateway 10.10.10.1
        dns-nameservers 1.1.1.1
# save the file and run the following commands
sudo /etc/init.d/networking restart

# reboot system if needed
'

# Apply Netplan configuration
sudo netplan apply

# Configure Firewall if needed
sudo ufw app list
sudo ufw allow openssh
sudo ufw enable
sudo ufw start