#!/bin/bash

#Prerequesits
echo "-- Installing git --"
install git
if [ "$(which $1)" != "" ]; then
    apt-get install $1 -y > /dev/null
fi

# Cloning Repo
echo "-- Cloning repo --"
git clone git@github.com:jim-fx/.dotfiles.git ~/.dotfiles

# Executing the script
echo "-- starting script --"
chmod +x ~/.dotfiles/setup.sh
~/.dotfiles/setup.sh