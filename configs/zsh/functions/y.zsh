function y(){
  word=$(echo "$1" | fold -w 1)
  for char in $(echo $word)
  do
    if [ $char = "i" ]; then
      yarn install
    elif [ $char = "d" ]; then
      yarn dev
    elif [ $char = "b" ]; then
      yarn build
    elif [ $char = "a" ]; then
      yarn add
    elif [ $char = "u" ]; then
      yarn upgrade
    elif [ $char = "t" ]; then
      yarn test
    elif [ $char = "c" ]; then
      yarn coverage
    fi
  done
}