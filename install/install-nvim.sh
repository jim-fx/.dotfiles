if [ -f "$HOME/.config/nvim/init.lua" ]; then
  echo " - moving old file to init.lua.BAK"
  mv "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua.BAK"
fi

echo " - linking init.vim --> init.vim"
mkdir -p $HOME/.config/nvim
ln -s "$HOME/.dotfiles/configs/init.lua" "$HOME/.config/nvim/init.lua"
ln -s "$HOME/.dotfiles/configs/lua" "$HOME/.config/nvim/lua"

echo " - installing paq-nvim"
sh -c 'git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim'

echo " - installing vim plugins"
nvim --headless +PaqSync +qa
