# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# This function emits an OSC 1337 sequence to set a user var
# associated with the current terminal pane.
# It requires the `base64` utility to be available in the path.
# This function is included in the wezterm shell integration script, but
# is reproduced here for clarity
__wezterm_set_user_var() {
  if hash base64 2>/dev/null ; then
    if [[ -z "${TMUX}" ]] ; then
      printf "\033]1337;SetUserVar=%s=%s\007" "$1" `echo -n "$2" | base64`
    else
      # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
      # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
      printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$1" `echo -n "$2" | base64`
    fi
  fi
}

function _run_prog() {
    # set PROG to the program being run
    __wezterm_set_user_var "PROG" "$1"

    # arrange to clear it when it is done
    trap '__wezterm_set_user_var PROG ""' EXIT

    # and now run the corresponding command, taking care to avoid looping
    # with the alias definition
    command "$@"
}

alias -s {yml,yaml,ts,json,js,vim,rc}=nvim

alias c="code ."
alias ca="c -a"
alias cr="c -r"

alias yoink="curl"

alias pls='sudo -E env "PATH=$PATH"'

alias online="ping 1.1.1.1"

alias vim="_run_prog nvim"
alias v="_run_prog nvim"

alias gcm="git commit -m "

alias D="run dev"
alias B="run build"
alias T="run test"

alias P="git push"
alias p="git pull"

alias lt="tree -L 2 --filelimit 150 --dirsfirst"

alias captive="xdg-open http://$(ip --oneline route get 1.1.1.1 | awk '{print $3}')"

if docker compose &> /dev/null
then
  alias dc="sudo docker compose"
else
  alias dc="sudo docker-compose"
fi


alias d="sudo docker"

alias t="tmux"

alias nx="pnpm exec nx"
alias pm="pnpm prisma"

if type lsd &> /dev/null; then
  alias ls="lsd"
fi

if type bat &> /dev/null; then
  alias cat="bat"
fi
