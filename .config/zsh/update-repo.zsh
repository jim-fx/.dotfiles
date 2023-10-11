if [ -d "~/.dotfiles" ]; then
    
    currentDir=$(pwd)

    VN=$(git describe --abbrev=7 HEAD 2>/dev/null)

    git update-index -q --refresh
    CHANGED=$(git diff-index --name-only HEAD --)
    if [ ! -z $CHANGED ]; then
        cd ~/.dotfiles
        git reset --hard origin/main
        git pull origin main
        zshu
    fi
fi
