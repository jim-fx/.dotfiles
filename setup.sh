#!/bin/bash

function isInstalled(){
  if [ "$(which $1)" != "" ]; then
    return 0;
  fi
  return 1;
}

function installOptional(){
  echo "install optional '$*'"

  # Check if any of the listed programs are installed
  # if not install the first one;
  for prog in "$@"
  do
      if isInstalled $prog; then
        echo "$prog is installed";
        break
      fi
  done

  install $1;

}

function install {
    # Check if program is already installed
    if isInstalled $1; then
      echo "$1 is already installed"
    else
      echo "installing $1"
      apt-get install $1
    fi
}


#Prerequesits
echo "-- Installing prerequisites --"
install git
install curl

echo "-- Installing Oh-My-Zsh --"
install zsh
./install/oh-my-szh.sh
./install/p10k.sh

install nope