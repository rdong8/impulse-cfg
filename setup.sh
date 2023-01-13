#!/bin/bash

function setup() {
  # Exit if there is an error
  set -e  

  # This will error if the directory already exists, preventing this script from being run twice without the user knowing
  mkdir /var/log/impulse/ 

  sudo apt update
  sudo apt install ansible	
  echo "alias impulse-pull=\"ansible-pull -U ssh://git@github.com:rdong8/impulse-cfg.git |& tee -a /var/log/impulse/impulse-pull.log\"" >> ~/.bashrc
  sudo impulse-pull
}

setup |& tee -a /var/log/impulse/setup.log
