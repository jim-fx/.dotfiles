function isInstalled(){
  if [ "$(which $1)" != "" ]; then
    return 0;
  fi
  return 1;
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

#Prerequesits
echo "-- Installing prerequisites --"
install git

echo "-- Cloning repo --"
git clone git@github.com:jim-fx/.dotfiles.git ~/.dotfiles

echo "-- starting script --"
chmod +x ~/.dotfiles/setup.sh
~/.dotfiles/setup.sh