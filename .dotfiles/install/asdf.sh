if [ -d ~/.asdf ] ; then
    echo " ✓ asdf already installed"
else
    git clone --quiet https://github.com/asdf-vm/asdf.git ~/.asdf > /dev/null
    cd ~/.asdf
    git checkout --quiet "$(git describe --abbrev=0 --tags)" > /dev/null
    . asdf.sh
fi
