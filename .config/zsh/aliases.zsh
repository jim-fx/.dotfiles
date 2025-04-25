alias -s {yml,yaml,ts,json,js,vim,rc}=nvim

alias pls='sudo -E env "PATH=$PATH"'

alias v="nvim"

alias D="run dev"
alias B="run build"
alias T="run test"

alias P="git push"
alias p="git pull"

alias lt="tree -L 2 --filelimit 150 --dirsfirst"
alias ll="ls -lah"

alias captive="xdg-open http://$(ip --oneline route get 1.1.1.1 | awk '{print $3}')"

if docker compose &> /dev/null
then
  alias dc="docker compose"
else
  alias dc="sudo docker-compose"
fi

if podman-compose &> /dev/null; then
  alias pc="podman-compose"
fi

alias d="docker"

if type bat &> /dev/null; then
  alias cat="bat"
fi

alias dots="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lazydots="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"
