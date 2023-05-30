#!/bin/bash

# Update package lists
sudo apt update

# Install Samba
yes | sudo apt install samba

# Install Git
yes | sudo apt install git

# Install v4l2-ctl
yes | sudo apt install v4l-utils

yes | sudo apt install  curl

yes | sudo apt install zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

