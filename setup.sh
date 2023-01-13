#!/bin/bash

function setup() {
  # Exit if there is an error
  set -e  

  # This will error if the directory already exists, preventing this script from being run twice without the user knowing
  sudo mkdir /var/log/impulse/ 

  sudo apt-get update
  sudo apt-get install -y ansible

  echo "\n# Start from impulse-cfg setup.sh" >> ~/.bashrc
  echo "alias impulse-pull=\"ansible-pull -U ssh://git@github.com:rdong8/impulse-cfg.git |& sudo tee -a /var/log/impulse/impulse-pull.log\"" >> ~/.bashrc
  echo "# End impulse-cfg setup.sh" >> ~/.bashrc
  source ~/.bashrc
  sudo impulse-pull
}

setup |& tee -a /var/log/impulse/setup.log
