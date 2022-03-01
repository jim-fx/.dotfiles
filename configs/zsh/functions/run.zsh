function run(){
  HAS_MAKE="$(ls | grep Makefile)"
  HAS_PACKAGE="$(ls | grep package.json)"

  if [ "$HAS_PACKAGE" != "" ]; then
    pnpm $1
  elif [ "$HAS_MAKE" != "" ]; then
    make $1
  fi

}
