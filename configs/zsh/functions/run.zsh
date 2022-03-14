function run(){
  if [[ -f "package.json" ]]; then
    pnpm $1
  elif [[ -f "Makefile" ]]; then
    make $1
  fi
}
