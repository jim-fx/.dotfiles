# Update Repo
# source $HOME/.dotfiles/configs/zsh/update-repo.zsh

export SHELL=/usr/bin/zsh

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# This should fix up arrow autocompletion with the zsh-vi-mode plugin
function zvm_before_init() {
  zvm_bindkey viins '^[[A' history-beginning-search-backward
  zvm_bindkey viins '^[[B' history-beginning-search-forward
  zvm_bindkey vicmd '^[[A' history-beginning-search-backward
  zvm_bindkey vicmd '^[[B' history-beginning-search-forward
  export ZVM_VI_EDITOR=nvim
  export ZVM_INIT_MODE=sourcing
}

if [ -f "$HOME/.config/zsh/antigen.zsh" ] ; then
  source $HOME/.config/zsh/antigen.zsh
  antigen use oh-my-zsh
  antigen bundle git
  # antigen bundle docker
  antigen bundle sudo
  # antigen bundle asdf
  # antigen bundle jeffreytse/zsh-vi-mode
  antigen theme romkatv/powerlevel10k
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle command-not-found
  antigen apply
fi

# Enable vim mode in zsh
bindkey -v

if type fzf &> /dev/null ; then
  source <(fzf --zsh)
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -d "$HOME/.asdf" ] ; then
   . "$HOME/.asdf/asdf.sh"
fi

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


export FPATH=$FPATH:~/.config/zsh/completions
export NVR_CMD=""

# Load oh my zsh
# export ZSH=~/.oh-my-zsh
# source $ZSH/oh-my-zsh.sh

## FUNCTIONS ##
source $HOME/.config/zsh/functions.zsh

## WEZTERM INTEGRATIONS ##
source $HOME/.config/zsh/wezterm.sh

## LOADING PROGRAMS
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/sbin"

## Setup VIM
export EDITOR="nvim"

# Automatically load direnv if found 
[[ -s $(which direnv) ]] && eval "$(direnv hook zsh)"

if [ type open &> /dev/null ]; then
else
  alias open=xdg-open
fi

[[ -s $(which mise) ]] && eval "$(mise activate zsh)"

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

# If podman is installed load the autocompletion
if type podman &> /dev/null; then
  source <(podman completion zsh)
fi

if type podman-compose &> /dev/null; then
  alias pc=podman-compose
fi

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

[ -n "$TMUX" ] && export TERM=tmux-256color

# pnpm
export PNPM_HOME="/home/max/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
#
export PATH="$HOME/.flutter/bin:$PATH"

export ANDROID_HOME="$HOME/Android"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/tools/bin"


zvm_after_init_commands+=("bindkey '^[[A' up-line-or-search" "bindkey '^[[B' down-line-or-search")

eval `dircolors ~/.dircolors`

if type cargo &> /dev/null; then
  export PATH="$HOME/.cargo/bin:$PATH"
  . "$HOME/.cargo/env"
fi
