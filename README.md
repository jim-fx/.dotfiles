# jim-fx's Dotfiles

## Features
- [ZSH](https://www.zsh.org/) + [oh-my-zsh](https://ohmyz.sh/) + [p10k](https://github.com/romkatv/powerlevel10k)
- [asdf version manager](https://asdf-vm.com/#/)
- [pre-configured](./configs/init.vim) [neovim](https://neovim.io/)
- 1 line installation

## Installation

*Unsupervised*

```bash
sh -c "$(curl -L setup.jim-fx.com)"
```

*Manual*

```bash
git clone git@github.com:jim-fx/.dotfiles.git ~/.dotfiles
chmod +x ~/.dotfiles/setup.sh
~/.dotfiles/setup.sh
```

## Testing

If you want to test the script before you can run the provided docker image.

```bash
docker build . -t jim-fx/dotfiles
docker run -it jim-fx/dotfiles
```
