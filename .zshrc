##### ENVIRONMENT SETUP #####

export SHELL="/usr/bin/zsh"
export EDITOR="nvim"

export HISTFILE="$HOME/.zsh_history"  # History file
export HISTSIZE=100000                # Lines kept in memory
export SAVEHIST=100000                # Lines saved to file

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/sbin"

export FPATH="$FPATH:$HOME/.config/zsh/completions"
export NVR_CMD=""

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Android & Flutter
export PATH="$HOME/.flutter/bin:$PATH"
export ANDROID_HOME="$HOME/Android"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/tools/bin"


##### INSTANT PROMPT (Powerlevel10k) #####
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##### FUNCTIONS #####


##### ZCOMET PLUGIN MANAGEMENT #####

# Load zcomet (you need to install it first!)
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Plugins
zcomet load zsh-users/zsh-autosuggestions
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load jeffreytse/zsh-vi-mode
zcomet load romkatv/powerlevel10k
zcomet compinit   # faster completions
# zcomet trigger

# Hooks must be set BEFORE zsh-vi-mode is initialized (good here)
function zvm_before_init() {
  zvm_bindkey viins '^[[A' history-beginning-search-backward
  zvm_bindkey viins '^[[B' history-beginning-search-forward
  zvm_bindkey vicmd '^[[A' history-beginning-search-backward
  zvm_bindkey vicmd '^[[B' history-beginning-search-forward
  export ZVM_VI_EDITOR="nvim"
  export ZVM_INIT_MODE="sourcing"
}


[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

##### CUSTOM FILES #####

source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/wezterm.sh"

##### PROGRAM-SPECIFIC INTEGRATIONS #####

exists() {
  command -v "$1" >/dev/null 2>&1
}

exists direnv && eval "$(direnv hook zsh)"
exists mise && eval "$(mise activate zsh)"

exists xdg-open && alias open="xdg-open"
exists podman-compose && alias pc="podman-compose"

exists podman && source <(podman completion zsh)

exists cargo && {
  export PATH="$HOME/.cargo/bin:$PATH"
  . "$HOME/.cargo/env"
}

exists go && export PATH="$PATH:$(go env GOPATH)/bin"

exists rg && {
  export FZF_DEFAULT_COMMAND="rg --files"
  export FZF_DEFAULT_OPTS="-m --height 50% --border"
}

exists fdfind && {
  export FZF_DEFAULT_COMMAND="fdfind --type f"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}

exists fzf && {
  source <(fzf --zsh)
  bindkey -M viins '^R' fzf-history-widget
  bindkey -M vicmd '^R' fzf-history-widget
  bindkey '^R' fzf-history-widget
}

exists dircolors && {
  eval "$(dircolors ~/.dircolors)"
  alias ls='ls --color=auto'
}
