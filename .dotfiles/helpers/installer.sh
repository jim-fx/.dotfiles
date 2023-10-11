#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}


package_manager=$1
# Detect the package manager
if command_exists apt-get; then
  package_manager="apt"
elif command_exists yum; then
  package_manager="yum"
elif command_exists pacman; then
  package_manager="pacman"
else
  echo "Unsupported package manager. Exiting."
  exit 1
fi

# Function to install packages based on the package manager
install_package() {

  case $package_manager in
    apt)
      sudo apt-get install -y $1
      ;;
    yum)
      sudo yum install -y $1
      ;;
    pacman)
      sudo pacman -S --noconfirm $1
      ;;
    *)
      echo "Unsupported package manager: $package_manager"
      exit 1
      ;;
  esac
}
