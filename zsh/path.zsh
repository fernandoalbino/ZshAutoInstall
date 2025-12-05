typeset -U path PATH
path=(
  $HOME/.local/bin
  $HOME/bin
  /usr/local/bin
  $path
)
export PATH
