function run(){
    if [ -f "pom.xml" ]; then
        mvn "$@"
    elif [ -f "pnpm-lock.yaml" ]; then
        pnpm "$@"
    elif [ -f "yarn.lock" ]; then
        yarn "$@"
    elif [ -f "Cargo.toml" ]; then
      cargo "$@"
    elif [ -f "package-lock.json" ]; then
        npm "$@"
    elif [ -f "Makefile" ]; then
        make $1
    else
        echo "No known package manager detected."
        return 1
    fi
}
