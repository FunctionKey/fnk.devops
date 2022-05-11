# Check which shell you are using
which $SHELL
# Ex: /bin/bash

# Start every bash file with a Shebang
# #!/bin/bash

# File has to be saved with .sh extention

# Add execute permission to file
chmod +x file.sh

# Run bash file
bash file.sh
./file.sh

# Reset VM's ssh key in case VM is reseted itself
sudo ssh-keygen -f "/home/fnk/.ssh/known_hosts" -R "192.168.4.22"

# Change the owner of /file to "root"
chown root /file
# Likewise, but also change its group to "staff"
chown root:staff /file

# Check open ports on local system
ss -tunpo state listening   # (-t) TCP (-u) and UDP (-n) port numbers (-p) and their associated process IDs