#!/usr/bin/env bash
set -e

# ================================================
# CONFIGURÁVEIS (para futuro uso com dotfiles git)
# ================================================
# Se no futuro você tiver um repositório de dotfiles privado,
# coloque a URL aqui, por exemplo:
# DOTFILES_REPO="git@github.com:seu-usuario/dotfiles.git"
DOTFILES_REPO=""

# Diretórios usados pelo setup
ZDOTDIR="$HOME/.config/zsh"
ZSH_HISTORY_DIR="$HOME/.local/share/zsh"
STARSHIP_CONFIG_DIR="$HOME/.config"
KONSOLE_DIR="$HOME/.local/share/konsole"

# ================================================
# 0. DETECÇÃO DE SISTEMA / GERENCIADOR DE PACOTES
# ================================================
detect_pkg_manager() {
    if command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v apt &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

PKG_MGR=$(detect_pkg_manager)

echo "==========================================================="
echo "  Instalação completa do ambiente ZSH + Starship + Plugins "
echo "  Gerenciador de pacotes detectado: $PKG_MGR"
echo "==========================================================="

if [[ "$PKG_MGR" == "unknown" ]]; then
    echo "ERRO: não consegui detectar um gerenciador de pacotes suportado."
    echo "Suportados: pacman, apt, dnf, zypper."
    exit 1
fi

# ================================================
# 1. INSTALAR PACOTES BASE + EXTRAS DEV
# ================================================
install_packages() {
    case "$PKG_MGR" in
        pacman)
            sudo pacman -Sy --noconfirm --needed \
                zsh git curl unzip fzf neofetch fastfetch

            # Terminais extra e ferramentas de dev (best effort)
            sudo pacman -Sy --noconfirm --needed \
                kitty alacritty yakuake ripgrep fd eza bat tmux || true
            ;;

        apt)
            sudo apt update
            # Base
            sudo apt install -y zsh git curl unzip fzf neofetch || true
            # Fastfetch pode não existir em todos os sistemas
            sudo apt install -y fastfetch || true
            # Terminais / dev (ignora falhas)
            sudo apt install -y kitty alacritty yakuake ripgrep fd-find bat tmux 2>/dev/null || true
            ;;

        dnf)
            sudo dnf install -y zsh git curl unzip fzf neofetch || true
            sudo dnf install -y fastfetch kitty alacritty yakuake ripgrep fd-find bat tmux 2>/dev/null || true
            ;;

        zypper)
            sudo zypper refresh
            sudo zypper install -y zsh git curl unzip fzf neofetch || true
            sudo zypper install -y fastfetch kitty alacritty yakuake ripgrep fd-find bat tmux 2>/dev/null || true
            ;;
    esac
}

echo "[1/10] Instalando pacotes base..."
install_packages

# Verificação mínima
if ! command -v zsh &>/dev/null; then
    echo "ERRO: zsh não foi instalado corretamente."
    exit 1
fi

# ================================================
# 2. BACKUP DO AMBIENTE ANTIGO
# ================================================
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.zsh_env_backup_$TIMESTAMP"

echo "[2/10] Fazendo backup de configurações antigas em: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP_DIR/.zshrc.old"
[ -d "$ZDOTDIR" ] && mv "$ZDOTDIR" "$BACKUP_DIR/zsh_config.old"
[ -f "$STARSHIP_CONFIG_DIR/starship.toml" ] && mv "$STARSHIP_CONFIG_DIR/starship.toml" "$BACKUP_DIR/starship.toml.old"
[ -d "$KONSOLE_DIR" ] && cp -r "$KONSOLE_DIR" "$BACKUP_DIR/konsole.old"

# Guardar caminho do último backup para o desinstalador
echo "$BACKUP_DIR" > "$HOME/.zsh_env_last_backup"

# ================================================
# 3. INSTALAR OH-MY-ZSH
# ================================================
echo "[3/10] Instalando Oh-My-Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ================================================
# 4. CLONE DE DOTFILES PRIVADOS (SE CONFIGURADO)
# ================================================
DOTFILES_DIR="$HOME/.dotfiles"

if [[ -n "$DOTFILES_REPO" ]]; then
    echo "[4/10] Clonando dotfiles privados de: $DOTFILES_REPO"
    if [ -d "$DOTFILES_DIR" ]; then
        echo "  Diretório $DOTFILES_DIR já existe, pulando clone."
    else
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
fi

# ================================================
# 5. INSTALAÇÃO DE PLUGINS EXTERNOS
# ================================================
echo "[5/10] Instalando plugins externos do Zsh..."

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

clone_if_missing() {
    local repo_url="$1"
    local dest_dir="$2"
    if [ ! -d "$dest_dir" ]; then
        git clone "$repo_url" "$dest_dir"
    fi
}

clone_if_missing https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

clone_if_missing https://github.com/marlonrichert/zsh-autocomplete \
    "$ZSH_CUSTOM/plugins/zsh-autocomplete"

clone_if_missing https://github.com/zsh-users/zsh-completions \
    "$ZSH_CUSTOM/plugins/zsh-completions"

clone_if_missing https://github.com/hlissner/zsh-autopair \
    "$ZSH_CUSTOM/plugins/zsh-autopair"

clone_if_missing https://github.com/changyuheng/zsh-interactive-cd \
    "$ZSH_CUSTOM/plugins/zsh-interactive-cd"

clone_if_missing https://github.com/Aloxaf/fzf-tab \
    "$ZSH_CUSTOM/plugins/fzf-tab"

# ================================================
# 6. INSTALAR STARSHIP + FONTE NERD
# ================================================
echo "[6/10] Instalando Starship..."
if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "[6.1] Instalando JetBrainsMono Nerd Font..."
mkdir -p "$HOME/.local/share/fonts"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
curl -L "$FONT_URL" -o /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d "$HOME/.local/share/fonts" > /dev/null
fc-cache -f

# ================================================
# 7. CRIAR ARQUITETURA MODULAR DO ZSH
#    (usa dotfiles, se existir; senão gera padrão)
# ================================================
echo "[7/10] Criando estrutura modular do Zsh..."

mkdir -p "$ZDOTDIR"
mkdir -p "$ZSH_HISTORY_DIR"

# ~/.zshrc minimalista
cat > "$HOME/.zshrc" << 'EOF'
export ZDOTDIR="$HOME/.config/zsh"
source "$ZDOTDIR/zshrc"
EOF

# Se existir dotfiles/zsh, copiar de lá; senão, gerar padrão
if [[ -d "$DOTFILES_DIR/zsh" ]]; then
    echo "  Usando configuração de Zsh do repositório de dotfiles..."
    cp -r "$DOTFILES_DIR/zsh/." "$ZDOTDIR/"
else
    echo "  Gerando configuração de Zsh padrão..."

    cat > "$ZDOTDIR/zshrc" << 'EOF'
for file in "$ZDOTDIR"/*.zsh; do
    [ -f "$file" ] && source "$file"
done
EOF

    cat > "$ZDOTDIR/path.zsh" << 'EOF'
typeset -U path PATH
path=(
  $HOME/.local/bin
  $HOME/bin
  /usr/local/bin
  $path
)
export PATH
EOF

    cat > "$ZDOTDIR/env.zsh" << 'EOF'
export LANG=pt_BR.UTF-8
export LC_CTYPE=pt_BR.UTF-8
export EDITOR="nano"

export ZSH="$HOME/.oh-my-zsh"
EOF

    cat > "$ZDOTDIR/plugins.zsh" << 'EOF'
plugins=(
  git
  colorize
  zsh-completions
  fzf
  fzf-tab
  zsh-interactive-cd
  zsh-autopair
  zsh-autosuggestions
  zsh-autocomplete
  zsh-history-substring-search
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOCOMPLETE_USE_WIDGETS=true
EOF

    cat > "$ZDOTDIR/history.zsh" << 'EOF'
HISTFILE="$HOME/.local/share/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE

# Importa histórico antigo (se existir) apenas uma vez
if [[ -f "$HOME/.zsh_history" && ! -s "$HISTFILE" ]]; then
    cat "$HOME/.zsh_history" >> "$HISTFILE"
fi
EOF

    cat > "$ZDOTDIR/aliases.zsh" << 'EOF'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias zshconfig="nano ~/.config/zsh"
alias ohmyzsh="nano ~/.oh-my-zsh"
EOF

    cat > "$ZDOTDIR/ui.zsh" << 'EOF'
setopt no_nomatch

# Fastfetch ao abrir terminal interativo
if [[ $- == *i* ]]; then
    fastfetch
fi

# Prompt Starship
eval "$(starship init zsh)"
EOF

    cat > "$ZDOTDIR/perf.zsh" << 'EOF'
zmodload zsh/zprof
unsetopt CORRECT_ALL

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu yes select

zstyle ':fzf-tab:*' fuzzy-match yes
zstyle ':fzf-tab:*' switch-group ',' '.'
EOF
fi

chmod 600 "$ZSH_HISTORY_DIR/history"

# ================================================
# 8. TEMA DARKPRO DO KONSOLE + PERFIL
#    (usa dotfiles se existir)
# ================================================
echo "[8/10] Configurando tema do Konsole..."
mkdir -p "$KONSOLE_DIR"

if [[ -d "$DOTFILES_DIR/konsole" ]]; then
    echo "  Usando perfis/temas do repositório de dotfiles..."
    cp -r "$DOTFILES_DIR/konsole/." "$KONSOLE_DIR/"
else
    cat > "$KONSOLE_DIR/DarkPro.colorscheme" << 'EOF'
[Background]
Color=10,12,14
[Foreground]
Color=230,230,230
[BackgroundIntense]
Color=20,22,25
[ForegroundIntense]
Color=255,255,255
[BackgroundFaint]
Color=5,5,5
[ForegroundFaint]
Color=160,160,160
[Color0]
Color=30,30,30
[Color0Intense]
Color=55,55,55
[Color1]
Color=180,60,70
[Color1Intense]
Color=230,80,90
[Color2]
Color=90,160,80
[Color2Intense]
Color=120,200,110
[Color3]
Color=210,180,95
[Color3Intense]
Color=240,210,120
[Color4]
Color=90,130,210
[Color4Intense]
Color=120,160,240
[Color5]
Color=160,90,150
[Color5Intense]
Color=200,120,190
[Color6]
Color=70,180,190
[Color6Intense]
Color=120,210,220
[Color7]
Color=200,200,200
[Color7Intense]
Color=240,240,240
[General]
Description=DarkPro High Contrast
Opacity=1
Wallpaper=
EOF

    cat > "$KONSOLE_DIR/DarkPro.profile" << 'EOF'
[Appearance]
ColorScheme=DarkPro
Font=JetBrainsMono Nerd Font Mono,12,-1,5,50,0,0,0,0,0

[Cursor Options]
CursorShape=1
CursorColor=230,230,230

[General]
Command=/usr/bin/zsh
Name=DarkPro
Parent=FALLBACK/
TerminalColumns=120
TerminalRows=32
WordCharacters=-,~,.,+,%,/,#,=,_,@,:,?

[Scrolling]
HistoryMode=2
HistorySize=100000

[Terminal Features]
BlinkingCursorEnabled=true
AudibleBell=false
EOF
fi

# ================================================
# 9. CONFIG DO STARSHIP (usa dotfiles se existir)
# ================================================
echo "[9/10] Criando configuração do Starship..."
mkdir -p "$STARSHIP_CONFIG_DIR"

if [[ -f "$DOTFILES_DIR/starship/starship.toml" ]]; then
    cp "$DOTFILES_DIR/starship/starship.toml" "$STARSHIP_CONFIG_DIR/starship.toml"
else
    cat > "$STARSHIP_CONFIG_DIR/starship.toml" << 'EOF'
format = """
$directory$git_branch$git_status
$character
"""

[directory]
style = "bold cyan"
truncation_length = 3

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
vicmd_symbol = "[❮](bold yellow)"
EOF
fi

# ================================================
# 10. FINAL
# ================================================
echo
echo "==========================================================="
echo "  Instalação concluída!"
echo "  - Abra o Konsole e selecione o perfil 'DarkPro'           "
echo "  - Abra um novo terminal para carregar o Zsh/Starship      "
echo "  Backup antigo em: $BACKUP_DIR"
echo "==========================================================="
