#!/bin/bash

echo "------------- UPDATE -------------"

sudo apt update

echo "------------- SAMBA -------------"

yes | sudo apt install samba

echo "------------- GIT -------------"

yes | sudo apt install git

echo "------------- V4L2-UTILS -------------"

yes | sudo apt install v4l-utils

echo "------------- CURL -------------"

yes | sudo apt install  curl

echo "------------- ZSH -------------"

yes | sudo apt install zsh

echo "------------- V4L2-LOOPBACK -------------"

yes | sudo apt install build-essential media-build
yes | sudo apt v4l2loopback-dkms

echo "------------- OH-MY-ZSH -------------"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

