#!/bin/bash
cd "$(dirname "$0")"

function isInstalled {
  if [ "$(which $1)" != "" ]; then
    return 0;
  fi
  return 1;
}

function installOptional {
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
      echo " - $1 is already installed"
    else
      echo " - installing $1 ..."
      apt-get install $1 -y > /dev/null
      echo " - finished"
    fi
}

function linkFile {
  #Move old file
  if [ -f "$HOME/$1" ]; then
    echo " - moving old file to $1_bak"
    mv "$HOME/$1" "$HOME/$1_bak"
  fi

  #Link $1
  echo " - linking $(pwd)/$1 --> $HOME/$1"
  ln -s "$(pwd)/$1" "$HOME/$1"
}

#Prerequesits
echo "-- Installing prerequisites --"
install git
install curl
install neovim

echo "-- Linking .dotfiles --"
linkFile .bashrc
linkFile .zshrc
linkFile .p10k.zsh
linkFile .gitconfig
linkFile .dircolors
linkFile .gitconfig-coco

echo "-- Installing Oh-My-Zsh --"
install zsh

sh $(pwd)/install/oh-my-zsh.sh
sh $(pwd)/install/zsh-autosuggestions.sh
zsh $(pwd)/install/p10k.sh

install direnv

echo "-- Configuring Optixal's Neovim (https://github.com/Optixal/neovim-init.vim) --"
sh $(pwd)/nvim/install-config.sh

echo "-- Applying .zshrc --"

if [ $SHELL != $(which zsh) ]; then
  echo "- changing default shell"
  chsh -s $(which zsh)
  export SHELL=$(which zsh)
fi

zsh

cd