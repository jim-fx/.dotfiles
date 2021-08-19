if [ -f "$HOME/.config/nvim/init.lua" ]; then
  echo " - moving old file to init.lua.BAK"
  mv "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua.BAK"
fi

echo " - linking init.vim --> init.vim"
mkdir -p $HOME/.config/nvim
ln -s "$HOME/.dotfiles/configs/init.lua" "$HOME/.config/nvim/init.lua"
ln -s "$HOME/.dotfiles/configs/lua" "$HOME/.config/nvim/lua"