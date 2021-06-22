#!/bin/bash

# - Prerequesits -
if [ "$(which git)" = "" ]; then
    echo "-- Installing git --"
    apt-get install git -y >/dev/null
fi

# - Cloning Repo -
echo "-- Cloning repo --"
git clone https://github.com/jim-fx/.dotfiles.git ~/.dotfiles

# - Executing the script -
echo "-- starting script --"
chmod +x ~/.dotfiles/setup.sh
~/.dotfiles/setup.sh
