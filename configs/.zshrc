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
  docker
  tmux
  asdf
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
export PATH="$PATH:/usr/sbin"

## Setup VIM
export EDITOR="nvim"

# Automatically load direnv if found 
[[ -s $(which direnv) ]] && eval "$(direnv hook zsh)"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.asdf" ] ; then
   . "$HOME/.asdf/asdf.sh"
fi

if [ "$(which go)" != "" ] ; then
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
if [ -e /home/jim/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jim/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

PATH="/home/jim/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jim/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jim/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jim/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jim/perl5"; export PERL_MM_OPT;
