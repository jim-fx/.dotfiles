FOLDER=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [ -s $FOLDER ]; then
  echo " ✓ powerlevel10k is already installed"
else
  echo " - cloning github.com/romkatv/powerlevel10k into $FOLDER"
  git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git $FOLDER > /dev/null
  echo " - finished"
fi