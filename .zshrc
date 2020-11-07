# INITILIZATION ##

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"


## for vxcsrv on wsl
export GOPATH="/home/jim/Sync"

plugins=(
  git
  npm
  zsh-autosuggestions
)

eval `dircolors ~/.dircolors`

# Load oh my zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

## FUNCTIONS ##

# Helps navigating Sync directory
function fx(){

  cd /home/jim/Sync/

  if [ "$1" = "o" ]; then

    cd $2

    code-insiders .

    if [ "$3" = "live" ]; then
      command live-server
    fi

  elif [ "$1" = "w" ]; then

    cd /Library/WebServer/Documents/

  elif [ "$1" = "s" ]; then
    cd $2
  fi

}

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

# Helps navigating COCO directory
function co(){

  cd ~/COCO

  openCode=false

  if [ "$1" = "o" ]; then
    1=$2;
    openCode=true
  fi

  first_dir=${1%/*};
  second_dir=${1#*/};

  if [ -z $first_dir ]; then
    first_dir=""
  fi

  if [ -z $second_dir ]; then
    second_dir=""
  fi

  if [ ! -v $first_dir ]; then
    coco_dir=$(ls | grep $first_dir | head -n 1)

    if [ -z "$coco_dir" ]; then

	echo "No directory exists for course $first_dir. Create a new one? (y/n)"

	read createDir

	if [ "$createDir" = "y" ]; then
		echo "What should the name be?"
		read dirName
		dirName=$first_dir"_$dirName"
		mkdir $dirName
		cd $dirName
		echo "Created $dirName"
	fi
	

    else

      cd $coco_dir
      amount=$(find ./* -maxdepth 0 -type d | wc -l)
      
      if [ "$amount" = "1" ]; then
        dir=$(find ./* -maxdepth 0 -type d)
        cd $dir
      fi

    fi

      if [ $second_dir != $first_dir ]; then
        cd $second_dir
      fi

    fi

    if [ $openCode = true ]; then
      code-insiders .
    fi

  }





# Helps with starting stuff
function start(){

  serviceName=$1;

  if [ $serviceName = "docker" ]; then

    dockerStatus="$(service docker status)"

    if [ "${dockerStatus#*"not running"}" != "$dockerStatus" ]; then
      echo "➜ starting docker"
      echo "➜    $(sudo service docker start)"
    fi

    sleep 0.5

  elif [ $serviceName = "mongo" ]; then

    start docker

    start container mongo

  elif [ $serviceName = "dc" ]; then

    start docker

    echo "➜ starting docker-compose"

    dc up -d

  elif [ $serviceName = "spring" ]; then

    start mongo

    echo "➜ starting spring-boot"

    mvn spring-boot:run

  elif [ $serviceName = "container" ]; then

    containerName=$2;

    containerInfo="[port:$(docker port $containerName) volume:$(docker inspect -f '{{index (.HostConfig.Binds) 0}}' $containerName)]"

    containerIsRunning="$(docker inspect -f '{{.State.Running}}' $containerName 2>/dev/null)"

    containerStatus="$(docker inspect -f '{{.State.Status}}' $containerName 2>/dev/null)"

    if [ $containerIsRunning = "true" ]; then
      echo "➜ $containerName already running $containerInfo"
    elif [ $containerStatus = "exited" ]; then
      echo "➜ running $containerName $containerInfo"
      echo "➜    id:$(sudo docker start $containerName)"
    else
      echo "➜ container $containerName $containerInfo doesnt exist"
    fi

  elif [ $serviceName = "dc" ]; then

    start docker

    echo "➜ starting docker-compose"

    dc up -d

  fi

}



## LOADING PROGRAMS

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:/usr/local"
export PATH="$PATH:/usr/local/vcpkg"
export PATH="$PATH:/usr/local/arduino"
export PATH="$PATH:/usr/local/processing"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

eval "$(direnv hook zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/jim/.sdkman"
[[ -s "/home/jim/.sdkman/bin/sdkman-init.sh" ]] && source "/home/jim/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Go version manager
[[ -s "/home/jim/.gvm/scripts/gvm" ]] && source "/home/jim/.gvm/scripts/gvm"