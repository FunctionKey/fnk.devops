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