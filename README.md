# jim-fx's Dotfiles

![screenshot](https://github.com/user-attachments/assets/157b4ac0-33ac-42d7-8771-942d6b0b66e4)

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
