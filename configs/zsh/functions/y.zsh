function y(){
  word=$(echo "$1" | fold -w 1)
  for char in $(echo $word)
  do
    if [ $char = "i" ]; then
      pnpm i -r
    elif [ $char = "d" ]; then
      pnpm dev
    elif [ $char = "b" ]; then
      pnpm build
    elif [ $char = "a" ]; then
      pnpm add
    elif [ $char = "u" ]; then
      pnpm upgrade
    elif [ $char = "t" ]; then
      pnpm test
    elif [ $char = "c" ]; then
      pnpm coverage
    fi
  done
}