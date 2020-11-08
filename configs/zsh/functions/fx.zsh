# Helps navigating Sync directory
function fx(){
  cd $HOME/SYNC/

  if [ "$2" != "" ]; then
    cd $2
  fi

  if [ "$1" = "o" ]; then
    code-insiders .
  fi
}