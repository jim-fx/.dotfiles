asdfInstall(){
    . "$HOME/.asdf/asdf.sh"
    if [ "$(which asdf)" = "" ]; then
        echo "Asdf not installed"
    else
        echo "-------------- ASDF install ------------------"
        echo "-- $1"
        asdf plugin add $1
        asdf install $1 latest
        asdf global $1 latest
        echo "----------------------------------------------"
    fi
}


[[ "${1}" != "--source-only" ]] && asdfInstall "${@}"
