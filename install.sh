#!/bin/zsh

# Interrompe o script em caso de qualquer erro
# set -e

echo "=================="
echo "Instalacao ohmyzsh"
echo "=================="

# CHSH=no impede a troca de shell imediata
# RUNZSH=no impede que o instalador abra um novo terminal e trave o script

# echo ""
if [ ! -d "~/.oh-my-zsh/"]; then
  KEEP_ZSHRC=yes CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "========================"
echo "Instalacao powerlevel10k"
echo "========================"
# Instalação no diretório correto de temas do Oh My Zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

echo "==========================="
echo "Instalacao do Tmux Plugin M."
echo "==========================="
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "========================================="
echo "Stow: nvim | zshrc | p10k.zsh | tmux.conf"
echo "========================================="
# Remove arquivos originais/padrão para evitar conflitos com o Stow
rm -f "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.tmux.conf"

# Executa o stow forçando links e limpando conflitos antigos
stow --adopt nvim zshrc p10k.zsh tmux.conf

echo "==================================================="
echo "Pronto! Configurações aplicadas."
echo "Control+s, I = Instalacao dos plugins do TPM (Tmux)"
echo "Control+s, r = Atualiza o Tmux"
echo "==================================================="
