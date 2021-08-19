FOLDER=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ -s $FOLDER ]; then
  echo " ✓ zsh-autosuggestions is already installed"
else
  echo " - cloning github.com/zsh-users/zsh-autosuggestions into $FOLDER"
  git clone --quiet https://github.com/zsh-users/zsh-autosuggestions $FOLDER > /dev/null
  echo " - finished"
fi