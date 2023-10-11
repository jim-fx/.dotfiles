# Helps navigating wordpress directory
function wp(){

  first_dir=${1%/*}
  second_dir=${1#*/}

  if [ $first_dir = $second_dir ]; then
    second_dir=""
  fi

  if [ $first_dir = "plugins" ]; then
    cd "wp-content/plugins"
  elif [ $first_dir = "themes" ]; then
    cd "wp-content/themes"
  fi

  if [ $second_dir != "" ]; then

  fi


}
