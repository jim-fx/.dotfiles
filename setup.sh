#!/bin/bash
cd "$(dirname "$0")"

INTERACTIVE=$(tty -s && echo "true" || echo "false")

echo "Interactive: $INTERACTIVE"

#Loading all the helper scripts
. ./helpers/installer.sh --source-only
. ./helpers/prompt.sh --source-only
. ./helpers/linker.sh --source-only
. ./helpers/multiselect.sh --source-only
. ./helpers/asdf-install.sh --source-only

echo "-- welcome to my setup script --"

if [ "$(which git)" = "" ] && ["$(which curl)" = ""]; then

  echo "-- installing prerequesits (git, curl) --"

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

if [ $INTERACTIVE = "true" ]; then
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

if [ $INTERACTIVE = "false" ]; then
  INST_ZSH=true
  INST_ASDF=true
  INST_NVIM=true
fi

echo "-----------------------------------"

echo -e "-- installing programs --"
[[ "$INST_DRNV" = true ]] && install direnv
if [ "$INST_ASDF" = true ]; then

    # Requirements for ASDF
    install gnupg2
    install unzip
    ./install/install-asdf.sh

    if [ "$INST_NVIM" = true ]; then
      asdfInstall neovim
      ./install/install-nvim.sh
    fi

    [[ "$INST_NODE" = true ]] && asdfInstall nodejs
    [[ "$INST_GO" = true ]] && asdfInstall golang
    [[ "$INST_PYTH" = true ]] && asdfInstall python
    [[ "$INST_DENO" = true ]] && asdfInstall deno
    [[ "$INST_HUGO" = true ]] && asdfInstall hugo
    [[ "$INST_RUST" = true ]] && asdfInstall rust
fi

echo "-- linking .dotfiles --"

linkFile .bashrc
linkFile .p10k.zsh
linkFile .dircolors
linkFile .tmux.conf

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
