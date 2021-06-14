# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  asdf
  zsh-autosuggestions
)

eval `dircolors ~/.dircolors`

# Load oh my zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

## FUNCTIONS ##
source $HOME/.dotfiles/configs/zsh/functions.zsh

## ALIASES ##
source $HOME/.dotfiles/configs/zsh/aliases.sh

## LOADING PROGRAMS
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/go/bin"

export PATH="$PATH:/mnt/c/users/jim/AppData/Local/Programs/Microsoft VS Code Insiders/bin";
export PATH="$PATH:/mnt/c/users/jim/AppData/Local/Programs/Microsoft VS Code/bin";

export DENO_INSTALL="/home/jim/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

## Setup VIM
export EDITOR="nvim"

## GO STUFF
export PATH=$PATH:/usr/local/go/bin

[[ -s $(which direnv) ]] && eval "$(direnv hook zsh)"

#Java version manager 
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Go version manager
#[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Node Version manager
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

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

# For wsl stay in the current dir when splitting panes?
export PROMPT_COMMAND='printf "\e]9;9;%s\e\\" "$(wslpath -m "$PWD")"'

source $HOME/.dotfiles/configs/zsh/update-repo.zsh

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/coder/downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/coder/downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/home/coder/downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/coder/downloads/google-cloud-sdk/completion.zsh.inc'; fi

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
