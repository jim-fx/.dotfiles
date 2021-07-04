if isInstalled "deno"; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/deno
    deno completions zsh > ~/.oh-my-zsh/custom/plugins/deno/_deno
fi


compdef _fx fx;
autoload -U compinit
compinit

