#!/bin/bash

# - Prerequesits -
if [ "$(which git)" = "" ]; then
    echo "-- Installing git --"
    apt-get install git -y >/dev/null
fi

# - Cloning Repo -
cd $HOME
if [ -d ".git" ] || git rev-parse --git-dir > /dev/null 2>&1; then
    # Get the remote URL
    remote_url=$(git config --get remote.origin.url)

    # Check if the remote URL contains a certain word
    if [[ $remote_url != *jim-fx/.dotfiles* ]]; then
      echo "Error: There is already a git repository setup at $HOME that is not pointing to the dotfiles"
    else
      echo "-- updating dotfiles --"
      git fetch
      git checkout -f main
    fi 
else
  echo "-- initializing dotfiles --"
  git init
  git remote add origin https://github.com/jim-fx/.dotfiles.git
  git fetch
  git checkout -f main
fi

# - Executing the script -
echo "-- starting setup script --"
~/.dotfiles/setup.sh
