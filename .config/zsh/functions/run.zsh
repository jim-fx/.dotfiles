function run(){
    if [ -f "pom.xml" ]; then
        mvn "$@"
    elif [ -f "appsettings.json" ]; then
        if [ $1 = "dev" ]; then
          dotnet watch
        else
          dotnet "$@"
        fi
    elif [ -f "go.mod" ]; then
        if [ $1 = "dev" ]; then
          go watch main.go
        else
          dotnet "$@"
        fi
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
