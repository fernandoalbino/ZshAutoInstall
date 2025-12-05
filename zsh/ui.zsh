setopt no_nomatch

if [[ $- == *i* ]]; then
    fastfetch
fi

eval "$(starship init zsh)"
