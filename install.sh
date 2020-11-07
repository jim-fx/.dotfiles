#!/bin/bash

# - Prerequesits -
echo "-- Installing git --"
if [ "$(which git)" != "" ]; then
    apt-get install git -y > /dev/null
fi

# - Cloning Repo - 
echo "-- Cloning repo --"
git clone git@github.com:jim-fx/.dotfiles.git ~/.dotfiles

# - Executing the script -
echo "-- starting script --"
chmod +x ~/.dotfiles/setup.sh
~/.dotfiles/setup.sh