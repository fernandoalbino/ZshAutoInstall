# -------------------------------------------------------------
# Universal environment variables (no locale assumptions)
# -------------------------------------------------------------

# Default editor detection (nano → vim → vi)
if command -v nano >/dev/null 2>&1; then
    export EDITOR="nano"
elif command -v vim >/dev/null 2>&1; then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

# Ensure XDG base directories exist
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Oh My Zsh directory (universal)
export ZSH="$HOME/.oh-my-zsh"
