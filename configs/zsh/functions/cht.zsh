languages=`echo "golang lua cpp c typescript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`

function cht(){
  selected=`printf "$languages\n$core_utils" | fzf`
   read query\?"query:"

  if printf $languages | grep -qs $selected; then
    curl cht.sh/$selected/`echo $query | tr ' ' '+'`
  else
    curl cht.sh/$selected~$query 
  fi
}
