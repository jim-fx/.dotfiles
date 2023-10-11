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