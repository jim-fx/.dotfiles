function conf(){

  OLD_PWD=$PWD;

  if [ "$1" = "u" ]; then
    source ~/.zshrc
  elif [ "$1" = "ssh" ]; then
    cd $HOME/.ssh/
    nvim config
  else
    cd ~/.dotfiles/

    if [ "$1" != "" ]; then
      cd configs
      cd $1
    fi

    if [[ -f "init.lua" ]]; then
      nvim init.lua
    elif [[ -f ".zshrc" ]]; then
      nvim .zshrc
      source ~/.zshrc
    elif [[ -f "config" ]]; then
      nvim config
    else
      nvim .
    fi

  fi

  cd $OLD_PWD

}
