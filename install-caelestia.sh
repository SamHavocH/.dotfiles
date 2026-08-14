#!/usr/bin/env bash
#
# Instalacao do Caelestia shell + meus keybinds no estilo lyne-dots.
# Pensado para uma instalacao limpa de Arch/CachyOS.
#
# Uso:
#   ./install-caelestia.sh            # interativo (perguntas do caelestia install)
#   ./install-caelestia.sh --noconfirm  # aceita os defaults em tudo
#
# O que ele faz:
#   1. garante git, stow e base-devel
#   2. garante um AUR helper (paru ou yay)
#   3. instala o caelestia-cli e roda "caelestia install"
#   4. faz stow do pacote "caelestia" deste repo (hypr-vars.lua, hypr-user.lua, shell.json)
#   5. recarrega o Hyprland se ele estiver rodando

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="$HOME/.config-backup/caelestia-$(date +%Y%m%d-%H%M%S)"
NOCONFIRM=""

for arg in "$@"; do
    case "$arg" in
        --noconfirm) NOCONFIRM="--noconfirm" ;;
        -h|--help) sed -n '3,15p' "${BASH_SOURCE[0]}"; exit 0 ;;
        *) echo "Argumento desconhecido: $arg" >&2; exit 1 ;;
    esac
done

titulo() {
    echo
    echo "=================================================="
    echo "$1"
    echo "=================================================="
}

if [ "$(id -u)" -eq 0 ]; then
    echo "Nao rode este script como root. Ele usa sudo quando precisa." >&2
    exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
    echo "Este script so funciona em Arch/CachyOS (pacman nao encontrado)." >&2
    exit 1
fi

titulo "Dependencias base"
sudo pacman -S --needed --noconfirm git stow base-devel

titulo "AUR helper"
if command -v paru >/dev/null 2>&1; then
    AUR_HELPER=paru
elif command -v yay >/dev/null 2>&1; then
    AUR_HELPER=yay
else
    echo "Nenhum AUR helper encontrado, compilando o yay..."
    BUILD_DIR="$(mktemp -d)"
    git clone --depth=1 https://aur.archlinux.org/yay-bin.git "$BUILD_DIR/yay-bin"
    (cd "$BUILD_DIR/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$BUILD_DIR"
    AUR_HELPER=yay
fi
echo "Usando: $AUR_HELPER"

titulo "Caelestia"
"$AUR_HELPER" -S --needed --noconfirm caelestia-cli
# O "caelestia install" instala o shell, o Hyprland e os componentes padrao.
caelestia install --aur-helper "$AUR_HELPER" $NOCONFIRM

titulo "Aplicando minhas configuracoes (stow)"
# O caelestia install cria hypr-vars.lua/hypr-user.lua vazios; guarda o que existir
# antes de deixar o stow criar os symlinks para este repo.
mkdir -p "$CONFIG_DIR/caelestia"
for arquivo in hypr-vars.lua hypr-user.lua shell.json; do
    alvo="$CONFIG_DIR/caelestia/$arquivo"
    if [ -e "$alvo" ] && [ ! -L "$alvo" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$alvo" "$BACKUP_DIR/$arquivo"
        echo "backup: $alvo -> $BACKUP_DIR/$arquivo"
    elif [ -L "$alvo" ]; then
        rm "$alvo"
    fi
done

stow -d "$DOTFILES_DIR" -t "$HOME" caelestia

titulo "Recarregando o Hyprland"
if command -v hyprctl >/dev/null 2>&1 && hyprctl version >/dev/null 2>&1; then
    hyprctl reload
    hyprctl configerrors || true
    echo "Hyprland recarregado."
else
    echo "Hyprland nao esta rodando agora; os binds valem no proximo login."
fi

titulo "Pronto"
echo "Shell Caelestia com os atalhos do lyne-dots."
echo "Mapa completo dos atalhos: $DOTFILES_DIR/docs/caelestia.md"
if [ -d "$BACKUP_DIR" ]; then
    echo "Arquivos antigos salvos em: $BACKUP_DIR"
fi
