#!/bin/bash

function setup() {
  sudo apt-get update
  sudo apt-get install -y ansible

  ANSIBLE_LOG="ANSIBLE_LOG_PATH=/var/log/impulse/ansible.log"
  PULL="ansible-pull -U ssh://git@github.com:rdong8/impulse-cfg.git |& sudo tee -a /var/log/impulse/impulse-pull.log"
  echo "\n# Start from impulse-cfg setup.sh" >> ~/.bashrc
  echo "$ANSIBLE_LOG alias impulse-pull=\"$PULL\"" >> ~/.bashrc
  echo "# End impulse-cfg setup.sh\n" >> ~/.bashrc
  source ~/.bashrc
  sudo impulse-pull
}

# Exit if there is an error
set -e  

# Errors if directory already exists, preventing script from accidentally being run twice
sudo mkdir /var/log/impulse/ 
sudo touch /var/log/impulse/setup.log

setup |& tee -a /var/log/impulse/setup.log
