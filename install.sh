#Prerequesits
echo "-- Installing git --"
install git
if [ "$(which $1)" != "" ]; then
    apt-get install $1 -y > /dev/null
fi

echo "-- Cloning repo --"
git clone git@github.com:jim-fx/.dotfiles.git ~/.dotfiles

echo "-- starting script --"
chmod +x ~/.dotfiles/setup.sh
~/.dotfiles/setup.sh