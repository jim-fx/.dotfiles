#!/bin/bash
cd "$(dirname "$0")"

. ./helpers/installer.sh --source-only
. ./helpers/prompt.sh --source-only
. ./helpers/linker.sh --source-only
. ./helpers/multiselect.sh --source-only

echo "-- welcome to my setup script --"
echo "-- installing prerequesits (git, curl) --"

INTERACTIVE=$(tty -s && echo "true" || echo "false")

if [ $INTERACTIVE = "true" ]; then
  if [ "$(prompt " - do you want to continue")" != "yes" ]; then
    echo "   alllrighty then, byyye"
    exit
  fi
fi

echo ""

#Prerequesits
echo "-- installing prerequisites --"

install git
install curl

echo "-----------------------------------"

#Make the selection
echo "-- what do you want to install? --"

OPTIONS_VALUES=("ZSH" "NVIM" "DRNV" "GVM" "NVM" "SDKM")
OPTIONS_LABELS=("zsh + oh-my-zsh" "Neovim" "Direnv" "Go Version Manager" "Node Version Manager" "Java Version Manager")
for i in "${!OPTIONS_VALUES[@]}"; do
  OPTIONS_STRING+="${OPTIONS_VALUES[$i]} (${OPTIONS_LABELS[$i]});"
done

if [ $INTERACTIVE = "true" ]; then
  multiselect SELECTED "$OPTIONS_STRING"
fi

# Variables
INST_ZSH=${SELECTED[0]}
INST_NVIM=${SELECTED[1]}
INST_DRNV=${SELECTED[2]}
INST_GVM=${SELECTED[3]}
INST_NVM=${SELECTED[4]}
INST_SDKM=${SELECTED[5]}

if [ $INTERACTIVE = "false" ]; then
  INST_ZSH = true
fi

echo "-----------------------------------"

echo -e "-- installing programs --"
[[ "$INST_DRNV" = true ]] && install direnv
[[ "$INST_GVM" = true ]] && echo " - installing GVM"
[[ "$INST_NVM" = true ]] && echo " - installing NVM"
[[ "$INST_SDKM" = true ]] && echo " - installing SDKM"

echo "-- linking .dotfiles --"

linkFile .bashrc
linkFile .p10k.zsh
linkFile .dircolors

echo "-----------------------------------"

if [ "$INST_ZSH" = true ]; then
  echo "-- installing oh-my-zsh --"
  linkFile .zshrc
  install zsh

  zsh $(pwd)/install/oh-my-zsh.sh
  zsh $(pwd)/install/zsh-autosuggestions.sh
  zsh $(pwd)/install/p10k.sh

  echo "-----------------------------------"
fi

if [ "$INST_NVIM" = true ]; then
  install neovim

  echo "-- Configuring Optixal's Neovim (https://github.com/Optixal/neovim-init.vim) --"

  sh $(pwd)/install/install-config.sh
  echo "-----------------------------------"
fi

if [ "$INST_ZSH" = true ]; then

  # Change default shell
  if [ $SHELL != $(which zsh) ]; then
    echo " - changing default shell"
    chsh -s $(which zsh)
    export SHELL=$(which zsh)
  fi

fi

# Change to home dir
cd ~

echo "-- ALL DONE --"

zsh
