function myip(){
  RES="$(curl -s ifconfig.co/json)"
  echo $RES | jq -r ' .ip '
  if [ "$1" = "-a" ]; then
    echo "$(echo $RES | jq -r '.country') | $(echo $RES | jq -r '.city')"
    echo "$(echo $RES | jq -r '.time_zone')"
  fi
}
