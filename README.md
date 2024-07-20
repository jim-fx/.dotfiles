# jim-fx's Dotfiles

![background](https://private-user-images.githubusercontent.com/29272343/350690681-dee6cb9a-86f5-4fab-94e2-9cb5f36cd9aa.png)

## Configurations
- [ZSH](https://www.zsh.org/) + [oh-my-zsh](https://ohmyz.sh/) + [p10k](https://github.com/romkatv/powerlevel10k)
- [neovim](https://neovim.io/)
- [sway](https://swaywm.org/) + [waybar](https://github.com/Alexays/Waybar)
- many more...

## Installation
```bash
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >> .gitignore
git clone --bare git@github.com:jim-fx/.dotfiles $HOME/.dotfiles
dots checkout
```

## Opinionated Stuff

Because this is mainly my personal configs there is some stuff which you should be aware of.

### Directories

- Personal projects are under ~/Projects
- Uni projects are under ~/COCO
- Binaries are under ~/bin

### Custom commands

```bash
fx [s/i/o/d] (directory)
```
Used to navigate and edit folders in the ~/Projects folder


```bash
co [number][name]
```

Used to navigate and edit folders in the ~/COCO folder
