if isInstalled "deno"; then
    mkdir -p ~/.oh-my-zsh/custom/plugins/deno
    deno completions zsh > ~/.oh-my-zsh/custom/plugins/deno/_deno
fi

compdef _fx fx;
compdef _arduino-cli arduino-cli;
autoload -U compinit
compinit
