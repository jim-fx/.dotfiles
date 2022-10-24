# Helps navigating Sync directory
function fx(){

  cd $HOME/Projects/

  if [ ! -d $2 ]; then
      echo "dir $2 does not exists"
      if read -q '?Do you want to create it (y/n)?'; then
        mkdir $2
      else
        echo -e "\nalllrighty then, byyye"
        return
      fi
  fi

  if [ "$2" != "" ]; then
    cd $2
  fi

  if [ "$1" = "d" ]; then
    dv
  fi

  if [ "$1" = "v" ]; then
    nvim
  fi

  if [ "$1" = "o" ]; then
    code-insiders .
  fi
}
