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
yes | sudo apt install curl

echo "------------- ZSH -------------"
yes | sudo apt install zsh

echo "------------- V4L2-LOOPBACK -------------"
yes | sudo apt install build-essential

echo "------------- V4L2-LOOPBACK -------------"
yes | sudo apt install v4l2loopback

if [[ -z "$ZSH" ]]; then
    echo "------------- OH-MY-ZSH -------------"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh-My-Zsh is already installed."
fi