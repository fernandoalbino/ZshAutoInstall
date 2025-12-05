#!/usr/bin/env bash
set -e

echo "==========================================================="
echo "  Desinstalação do ambiente ZSH + Starship + Plugins       "
echo "==========================================================="

BACKUP_MARKER="$HOME/.zsh_env_last_backup"

if [[ -f "$BACKUP_MARKER" ]]; then
    BACKUP_DIR=$(cat "$BACKUP_MARKER")
    echo "Backup encontrado em: $BACKUP_DIR"
else
    echo "Nenhum arquivo de backup encontrado. Vou apenas remover as configs novas."
    BACKUP_DIR=""
fi

read -rp "Continuar com a desinstalação? (y/N) " ans
[[ "$ans" =~ ^[Yy]$ ]] || { echo "Cancelado."; exit 0; }

# Remover configurações atuais
rm -rf "$HOME/.config/zsh"
rm -f "$HOME/.config/starship.toml"
rm -f "$HOME/.local/share/konsole/DarkPro.colorscheme"
rm -f "$HOME/.local/share/konsole/DarkPro.profile"

# Restaurar backup, se existir
if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
    echo "Restaurando arquivos do backup..."
    [ -f "$BACKUP_DIR/.zshrc.old" ] && mv "$BACKUP_DIR/.zshrc.old" "$HOME/.zshrc"
    [ -d "$BACKUP_DIR/zsh_config.old" ] && mv "$BACKUP_DIR/zsh_config.old" "$HOME/.config/zsh"
    [ -f "$BACKUP_DIR/starship.toml.old" ] && mv "$BACKUP_DIR/starship.toml.old" "$HOME/.config/starship.toml"
    if [ -d "$BACKUP_DIR/konsole.old" ]; then
        mkdir -p "$HOME/.local/share"
        rm -rf "$HOME/.local/share/konsole"
        mv "$BACKUP_DIR/konsole.old" "$HOME/.local/share/konsole"
    fi
fi

echo "Feito. Se quiser voltar a usar bash por padrão:"
echo "  chsh -s /bin/bash"
