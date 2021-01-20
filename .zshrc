# INITILIZATION ##

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(
  git
  zsh-autosuggestions
)

eval `dircolors ~/.dircolors`

# Load oh my zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

## FUNCTIONS ##
source $HOME/.dotfiles/zsh/functions.zsh

## ALIASES ##
source $HOME/.dotfiles/zsh/aliases.sh

## LOADING PROGRAMS
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:/usr/local"
export PATH="$PATH:/usr/local/vcpkg"
export PATH="$PATH:/usr/local/arduino"
export PATH="$PATH:/usr/local/processing"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

export GOROOT="$HOME/go"
export GOPATH="$HOME/SYNC"
export PATH="$PATH:$GOROOT/bin"

eval "$(direnv hook zsh)"

#Java version manager 
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Go version manager
[[ -s "/$HOME/.gvm/scripts/gvm" ]] && source "/$HOME/.gvm/scripts/gvm"

# Node Version manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
