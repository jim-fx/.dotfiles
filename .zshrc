export SHELL="/usr/bin/zsh"
export EDITOR="nvim"

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

export HISTFILE="$HOME/.zsh_history"  # History file
export HISTSIZE=100000                # Lines kept in memory
export SAVEHIST=100000                # Lines saved to file

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/sbin"

# Load custom autocompletions
export FPATH="$FPATH:$HOME/.config/zsh/completions"

# Setup p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup zcomet plugin manager
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

# Configure zsh vim mode to work with history
function zvm_before_init() {
  zvm_bindkey viins '^[[A' history-beginning-search-backward
  zvm_bindkey viins '^[[B' history-beginning-search-forward
  zvm_bindkey vicmd '^[[A' history-beginning-search-backward
  zvm_bindkey vicmd '^[[B' history-beginning-search-forward
  export ZVM_VI_EDITOR="nvim"
  export ZVM_INIT_MODE="sourcing"
}

# Custom functions, aliases & integrations
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/wezterm.sh"

# Program specific integrations

exists() {
  command -v "$1" >/dev/null 2>&1
}

exists-dir() {
  [ -d "$1" ]
}

exists mise && {
  eval "$(mise activate zsh)"
}

exists xdg-open && {
  alias open="xdg-open"
}

exists podman-compose && {
  alias pc="podman-compose"
}

exists podman && {
  source <(podman completion zsh)
}

exists bat && {
  alias cat="bat"
}


exists docker && {
  alias d="docker"
  alias dc="docker compose"
  source <(docker completion zsh)
}

exists cargo && {
  export PATH="$HOME/.cargo/bin:$PATH"
  . "$HOME/.cargo/env"
}

exists go && {
  export PATH="$PATH:$(go env GOPATH)/bin"
}

exists-dir "$HOME/.flutter" && {
  export PATH="$HOME/.flutter/bin:$PATH"
}

exists-dir "$HOME/Android" && {
  export ANDROID_HOME="$HOME/Android"
  export ANDROID_SDK_ROOT="$ANDROID_HOME"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
  export PATH="$PATH:$ANDROID_HOME/tools/bin"
}

exists rg && {
  export FZF_DEFAULT_COMMAND="rg --files"
  export FZF_DEFAULT_OPTS="-m --height 50% --border"
}

exists fdfind && {
  export FZF_DEFAULT_COMMAND="fdfind --type f"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}


fzf-history-from-file() {
  local histfile=${HISTFILE:-$HOME/.zsh_history}
  local selected

  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases noglob nobash_rematch 2> /dev/null

  if [[ -r "$histfile" ]]; then
    local history_lines

    # Detect EXTENDED_HISTORY format (starts with ": timestamp:duration;")
    if grep -qE '^: [0-9]+:' "$histfile"; then
      history_lines=$(cut -d ';' -f2- < "$histfile")
    else
      history_lines=$(<"$histfile")
    fi

    # Deduplicate while preserving order (first seen wins)
    selected=$(print -r -- "$history_lines" | tac | awk '!seen[$0]++' | \
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))
  fi

  local ret=$?
  if [[ -n "$selected" ]]; then
    LBUFFER="$selected"
  fi

  zle reset-prompt
  return $ret
}
zle -N fzf-history-from-file

exists fzf && {
  setopt INC_APPEND_HISTORY
  source <(fzf --zsh)
  bindkey -M viins '^R' fzf-history-from-file
  bindkey -M vicmd '^R' fzf-history-from-file
  bindkey '^R' fzf-history-from-file
}

exists pnpm && {
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
}

exists dircolors && {
  eval "$(dircolors ~/.dircolors)"
  alias ls='ls --color=auto'
}


# pnpm
export PNPM_HOME="/home/max/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
