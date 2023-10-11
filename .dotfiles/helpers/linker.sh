#!/bin/bash
linkFile() {
  #Move old file
  if [ -f "$HOME/$1" ]; then
    echo " - moving old file to $1_bak"
    mv "$HOME/$1" "$HOME/$1_bak"
  fi

  echo " - linking $1 --> $HOME/$1"

  ln -s "$(pwd)/configs/$1" "$HOME/$1"
}

[[ "${1}" != "--source-only" ]] && linkFile "${@}"
