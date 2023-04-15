# Update Repo
# source $HOME/.dotfiles/configs/zsh/update-repo.zsh


# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -d "$HOME/.asdf" ] ; then
   . "$HOME/.asdf/asdf.sh"
fi

if [ -f "$HOME/.config/zsh/antigen.zsh" ] ; then
  source $HOME/.config/zsh/antigen.zsh
  antigen use oh-my-zsh
  antigen bundle git
  antigen bundle docker
  antigen bundle asdf
  antigen bundle jeffreytse/zsh-vi-mode
  antigen theme romkatv/powerlevel10k
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen apply
fi

# Enable vim mode in zsh
bindkey -v

if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR=/run/user/$UID
  if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/tmp/$USER-runtime
    if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
      mkdir -m 0700 "$XDG_RUNTIME_DIR"
    fi
  fi
fi


# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_AUTOCONNECT=false

eval `dircolors ~/.dircolors`

export FPATH=$FPATH:~/.dotfiles/completions
export NVIM_HOME=$HOME/.config/nvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export NVR_CMD=""

# Load oh my zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

## FUNCTIONS ##
source $HOME/.dotfiles/configs/zsh/functions.zsh

## ALIASES ##
source $HOME/.dotfiles/configs/zsh/aliases.sh

## WEZTERM INTEGRATIONS ##
source $HOME/.dotfiles/configs/zsh/wezterm.sh

## LOADING PROGRAMS
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/sbin"

## Setup VIM
export EDITOR="nvim"

# Automatically load direnv if found 
[[ -s $(which direnv) ]] && eval "$(direnv hook zsh)"

if [ type open &> /dev/null ]; then
else
  alias open=xdg-open
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


if type go &> /dev/null ; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

#If fdfind is installed force fzf to use it
if type fdfind &> /dev/null ; then
    export FZF_DEFAULT_COMMAND='fdfind --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

#If ripgrep is installed prefer it over fdfind
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# If podman is installed load the autocompletion
if type podman &> /dev/null; then
  source <(podman completion zsh)
fi

if type podman-compose &> /dev/null; then
  alias pc=podman-compose
fi


# Auto connect to tmux session of ssh
if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
    # tmux attach-session -t $USER || tmux new-session -s $USER
fi

source "$HOME/."

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

[ -n "$TMUX" ] && export TERM=tmux-256color

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# pnpm
export PNPM_HOME="/home/max/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
