function note(){
  cd ~/Notes

  if [ "$1" != "" ]; then
    cd $1
  fi

  if [[ -f "index.md" ]]; then
    nvim index.md
  else
    nvim .
  fi
}

compctl -/ -W ~/Notes/$@ note
