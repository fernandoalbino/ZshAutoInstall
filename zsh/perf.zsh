zmodload zsh/zprof

unsetopt CORRECT_ALL

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu yes select

# Integração com fzf-tab
zstyle ':fzf-tab:*' fuzzy-match yes
zstyle ':fzf-tab:*' switch-group ',' '.'
