#!/bin/bash

function setup() {
  sudo apt-get update
  sudo apt-get install -y ansible

  sudo touch /var/log/impulse/ansible.log
  echo -e  "\n# Start impulse-cfg/setup.sh" >> ~/.bashrc
  echo "ANSIBLE_LOG_PATH=/var/log/impulse/ansible.log" >> ~/.bashrc
  PULL="ansible-pull -o -U ssh://git@github.com/rdong8/impulse-cfg.git |& sudo tee -a /var/log/impulse/impulse-pull.log"
  echo "alias impulse-pull=\"$PULL\"" >> ~/.bashrc
  echo -e "# End impulse-cfg/setup.sh\n" >> ~/.bashrc
  source ~/.bashrc
  sudo impulse-pull
}

# Exit if there is an error
set -e  

# Errors if directory already exists, preventing script from accidentally being run twice
sudo mkdir /var/log/impulse/ 
sudo touch /var/log/impulse/setup.log

setup |& sudo tee -a /var/log/impulse/setup.log
