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

eval "$(direnv hook zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/jim/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Go version manager
[[ -s "/$HOME/.gvm/scripts/gvm" ]] && source "/$HOME/.gvm/scripts/gvm"