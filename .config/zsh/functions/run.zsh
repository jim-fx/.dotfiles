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
          if [ -f "cmd/serve.go" ]; then
            go run main.go serve
          else
            go watch main.go
          fi
        else
          dotnet "$@"
        fi
    elif [ -f "yarn.lock" ]; then
        yarn "$@"
    elif [ -f "Cargo.toml" ]; then
      cargo "$@"
    elif [ -f "package-lock.json" ]; then
        npm "$@"
    elif [ -f "pnpm-lock.yaml" ] || [ -f "package.json" ]; then
        pnpm "$@"
    elif [ -f "Makefile" ]; then
        make $1
    else
        echo "No known package manager detected."
        return 1
    fi
}
