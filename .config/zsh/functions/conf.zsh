function conf(){

  OLD_PWD=$PWD;

  if [ "$1" = "u" ]; then
    source ~/.zshrc
  elif [ "$1" = "ssh" ]; then
    cd $HOME/.ssh/
    nvim config
  else
    cd ~/.config/

    if [ "$1" != "" ]; then
      cd $1
    fi

    if [[ -f ".zshrc" ]]; then
      nvim ~/.zshrc
      source ~/.zshrc
    else
      nvim .
    fi

  fi

  cd $OLD_PWD

}
