## ALIASIES ##
alias -s {yml,yaml,ts,json,js,vim,rc}=nvim

alias c="code ."
alias ca="c -a"
alias cr="c -r"

alias yoink="curl"

alias pls='sudo -E env "PATH=$PATH"'

alias online="ping 1.1.1.1"

alias vim="nvim"
alias v="nvim"

alias gcm="git commit -m "

alias D="run dev"
alias B="run build"
alias T="run test"

alias P="git push"
alias p="git pull"

alias lt="tree -L 2 --filelimit 150 --dirsfirst"

alias dc="docker-compose"

alias t="tmux"

alias nx="pnpm exec nx"
alias pm="pnpm prisma"

if type lsd &> /dev/null; then
  alias ls="lsd"
fi

if type bat &> /dev/null; then
  alias cat="bat"
fi
