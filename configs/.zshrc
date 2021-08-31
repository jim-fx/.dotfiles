# Update Repo
source $HOME/.dotfiles/configs/zsh/update-repo.zsh

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

plugins=(
  git
  asdf
  docker
  tmux
	zsh-autosuggestions
)

eval `dircolors ~/.dircolors`

export FPATH=$FPATH:~/.dotfiles/completions

# Load oh my zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

## FUNCTIONS ##
source $HOME/.dotfiles/configs/zsh/functions.zsh

## ALIASES ##
source $HOME/.dotfiles/configs/zsh/aliases.sh

## LOADING PROGRAMS
export PATH="$PATH:$HOME/bin"

## Setup VIM
export EDITOR="nvim"

# Automatically load direnv if found 
[[ -s $(which direnv) ]] && eval "$(direnv hook zsh)"

# Load DOTNet if found
if [ -d $HOME/.dotnet ]; then
  export DOTNET_ROOT=$HOME/.dotnet;
  export PATH=$PATH:$HOME/.dotnet;
fi

#Load pyenv if found
if [ -s "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi


#Load ASDF Version manager if found
if [ -s "$HOME/.asdf" ]; then
    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#If fdfind is installed force fzf to use it
if type fdfind > /dev/null ; then

    # Feed the output of fd into fzf
    # fdfind --type f | fzf

    # Setting fd as the default source for fzf
    export FZF_DEFAULT_COMMAND='fdfind --type f'

    # To apply the command to CTRL-T as well
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
