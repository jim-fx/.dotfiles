#Install oh my zsh
export CHSH=no
export RUNZSH=no
export KEEP_ZSHRC=yes

echo " - installing oh-my-zsh"
sh -c "$(
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
)" > /dev/null
echo " - finished"
