#!/bin/bash

INTERACTIVE=false
 if [ -t 0 ] ; then
    INTERACTIVE=true
 fi


#Loading all the helper scripts
source $HOME/.dotfiles/helpers/installer.sh
source $HOME/.dotfiles/helpers/prompt.sh
source $HOME/.dotfiles/helpers/multiselect.sh

echo "-- welcome to my setup script --"

if [ "$(which git)" = "" ] && ["$(which curl)" = ""]; then

  echo "-- installing prerequesits (git, curl) --"

  if [ $INTERACTIVE = true ]; then
    if [ "$(prompt " - do you want to continue")" != "yes" ]; then
      echo "   alllrighty then, byyye"
      exit
    fi
  fi

  install_package git
  install_package curl

  echo "-----------------------------------"

fi

#Make the selection
echo "-- what do you want to install? --"

OPTIONS_VALUES=(
  "ZSH" 
  "NVIM" 
  "ASDF" 
  "DRNV" 
  "NODE"   
  "GO"     
  "PYTH"   
  "DENO" 
  "HUGO" 
  "RUST"
  )
  
OPTIONS_LABELS=("zsh + oh-my-zsh" "Neovim (Requires asdf)" "asdf" "Direnv" "NodeJS" "Golang" "Python" "Deno" "Hugo" "Rust")
for i in "${!OPTIONS_VALUES[@]}"; do
  OPTIONS_STRING+="${OPTIONS_VALUES[$i]} (${OPTIONS_LABELS[$i]});"
done

if [ $INTERACTIVE = true ]; then
  multiselect SELECTED "$OPTIONS_STRING":
fi

# Variables
INST_ZSH=${SELECTED[0]}
INST_NVIM=${SELECTED[1]}
INST_ASDF=${SELECTED[2]}
INST_DRNV=${SELECTED[3]}
INST_NODE=${SELECTED[4]}
INST_GO=${SELECTED[5]}
INST_PYTH=${SELECTED[6]}
INST_DENO=${SELECTED[7]}
INST_HUGO=${SELECTED[8]}
INST_RUST=${SELECTED[9]}

if [ $INTERACTIVE = false ]; then
  INST_ZSH=true
  INST_ASDF=true
  INST_NVIM=true
fi

echo -e "-- installing programs --"

[[ "$INST_DRNV" = true ]] && install_package direnv
if [ "$INST_ASDF" = true ]; then

    # Requirements for ASDF
    install_package gnupg2
    install_package unzip
    $HOME/.dotfiles/install/asdf.sh

    if [ "$INST_NVIM" = true ]; then
      asdf_install neovim
    fi

    [[ "$INST_NODE" = true ]] && asdf_install nodejs
    [[ "$INST_GO" = true ]] && asdf_install golang
    [[ "$INST_PYTH" = true ]] && asdf_install python
    [[ "$INST_DENO" = true ]] && asdf_install deno
    [[ "$INST_HUGO" = true ]] && asdf_install hugo
    [[ "$INST_RUST" = true ]] && asdf_install rust
fi

if [ "$INST_ZSH" = true ]; then
  echo "-- installing oh-my-zsh --"
  install_package zsh

  zsh $HOME/.dotfiles/install/oh-my-zsh.sh
  zsh $HOME/.dotfiles/install/p10k.sh

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

if [ "$INST_ZSH" = true ]; then
    zsh
fi
