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

## Opinionated Stuff

Because this is mainly my personal configs there are some stuff which you should be aware of.

### Directories

- Personal projects are under ~/SYNC
- Uni projects are under ~/COCO
- Binaries are under ~/bin

### Custom commands

```bash
fx [s/i/o] (directory)
```
Used to navigate and edit folders in the ~/SYNC folder


```bash
co [number][name]
```

Used to navigate and edit folders in the ~/COCO folder
