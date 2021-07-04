if [ -f "$HOME/.config/nvim/init.vim" ]; then
  echo " - moving old file to init.vim.BAK"
  mv "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim.BAK"
fi

echo " - linking init.vim --> init.vim"
mkdir -p $HOME/.config/nvim
ln -s "$HOME/.dotfiles/configs/init.vim" "$HOME/.config/nvim/init.vim"

echo " - installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo " - installing vim plugins"
nvim --headless +PlugInstall +qa
