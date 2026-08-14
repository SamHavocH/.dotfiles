# Meus .dotfiles

Neste repositorio guardo as principais configuracoes de minhas ferramentas para continuar meu fluxo de trabalho em maquinas diferentes.
Mais do que isto, este repositorio serve tambem como backup.

## Conteudos 

### Ferramentas
- Neovim
- Tmux
- Zsh 
- Fastfetch

### Terminais
- Alacritty
- Kitty Terminal

### Desktop Environment (DE)
- Hyprland
- Sway
- Caelestia (shell do Hyprland, com os atalhos no estilo lyne-dots)

### Misc
- Waybar

### Pacotes externos:
- Tmux Plugin Manager (TPM)
- Oh-My-Zsh
- PowerLevel10K

### Fontes
Adicionalmente instalo a fonte JetBrainsMonoNerd caso ainda nao instalada para melhor funcionamento de meus TUIs
- JetBrainsMonoNerd

## Pacotes Configurados automaticamente via stow: 
Coloquei um script de instalacao que junta essas configuracoes usando o GNU stow para criar symlinks na .config e etc

- nvim
- zsh (oh-my-zsh)
- powerlevel10k
- tmux

## Caelestia (Hyprland)
Instalacao separada, pensada para uma maquina limpa de Arch/CachyOS:

```bash
./install-caelestia.sh
```

Instala o Caelestia (shell + Hyprland) pela AUR e aplica meus atalhos, que
seguem o layout do lyne-dots. A lista completa dos atalhos esta em
[docs/caelestia.md](docs/caelestia.md).


