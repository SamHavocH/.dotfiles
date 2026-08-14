# Caelestia com os atalhos do lyne-dots

O visual e o shell sao do [Caelestia](https://github.com/caelestia-dots/caelestia);
os atalhos seguem o layout do [lyne-dots](https://github.com/caioax/lyne-dots).

## Instalacao

Em uma maquina limpa (Arch/CachyOS):

```bash
git clone <este-repo> ~/.dotfiles
cd ~/.dotfiles
./install-caelestia.sh            # ou ./install-caelestia.sh --noconfirm
```

O script instala o `caelestia-cli` pela AUR, roda `caelestia install` (que traz o
shell, o Hyprland e os componentes padrao) e depois faz `stow caelestia` para
aplicar as configuracoes deste repo.

## Como as configuracoes sao aplicadas

Nada do Caelestia e editado diretamente: sao usados os dois pontos de extensao
oficiais, entao um `caelestia update` nao sobrescreve nada.

| Arquivo | Papel |
| --- | --- |
| `caelestia/.config/caelestia/hypr-vars.lua` | Sobrescreve as variaveis `kb*` do Caelestia |
| `caelestia/.config/caelestia/hypr-user.lua` | Binds que as variaveis nao cobrem + `hl.unbind` dos defaults conflitantes |
| `caelestia/.config/caelestia/shell.json` | Ajustes visuais do shell (transparencia) |

## Atalhos

### Janelas

| Atalho | Acao |
| --- | --- |
| `SUPER + H/J/K/L` | Move o foco |
| `SUPER + SHIFT + H/J/K/L` | Move a janela |
| `SUPER + ALT + H/J/K/L` | Redimensiona a janela |
| `SUPER + LMB / RMB` | Arrasta / redimensiona com o mouse |
| `SUPER + Q` | Fecha a janela |
| `SUPER + F` | Fullscreen |
| `SUPER + SHIFT + F` | Fullscreen com bordas (maximizado) |
| `SUPER + SHIFT + Space` | Flutuante |
| `SUPER + P` | Pseudo |
| `SUPER + Tab` | Togglesplit |
| `SUPER + ALT + P` | Pin |
| `SUPER + ALT + \` | Picture-in-picture |
| `SUPER + Comma` / `SUPER + U` | Agrupa / desagrupa |
| `ALT + Tab` | Cicla dentro do grupo |

### Workspaces

| Atalho | Acao |
| --- | --- |
| `SUPER + 1-0` | Vai para a workspace |
| `SUPER + SHIFT + 1-0` | Move a janela para a workspace |
| `CTRL + SUPER + H/L` (ou setas) | Workspace anterior / proxima |
| `CTRL + SUPER + SHIFT + H/L` | Move a janela para a workspace anterior / proxima |
| `CTRL + SUPER + 1-0` | Grupo de workspaces (10 em 10, por monitor) |
| `SUPER + W` / `SUPER + M` / `SUPER + S` | Special workspace: chat / musica / scratchpad |
| `SUPER + SHIFT + W/M/S` | Move a janela para a special workspace correspondente |
| `SUPER + R` | Special workspace de todo |
| `CTRL + SHIFT + Escape` | Monitor de sistema |

### Apps e shell

| Atalho | Acao |
| --- | --- |
| `SUPER + Return` | Terminal |
| `SUPER + D` | Gerenciador de arquivos |
| `SUPER + Z` | Navegador |
| `SUPER + C` | Editor |
| `SUPER + Space` | Launcher |
| `SUPER + End` | Menu de energia |
| `SUPER + N` / `SUPER + SHIFT + N` | Sidebar / mostra os paineis |
| `SUPER + V` | Historico de clipboard |
| `SUPER + Period` | Emojis |
| `SUPER + B` | Wallpaper aleatorio |
| `SUPER + = / -` | Zoom de tela |
| `Print` | Screenshot |
| `CTRL + SUPER + S` | Screenshot com freeze |
| `CTRL + ALT + L` | Lock |
| `CTRL + ALT + SHIFT + Delete` | Suspender |
| `CTRL + SUPER + M` | Mute |

## Defaults do Caelestia que foram realocados

Estes atalhos sairam do lugar padrao porque colidiam com o layout do lyne:

| Acao | Antes | Agora |
| --- | --- | --- |
| Suspender | `SUPER + SHIFT + L` | `CTRL + ALT + SHIFT + Delete` |
| Mute | `SUPER + SHIFT + M` | `CTRL + SUPER + M` |
| Screenshot com freeze | `SUPER + SHIFT + S` | `CTRL + SUPER + S` |
| Lock | `SUPER + L` | `CTRL + ALT + L` |
| Restaurar o lock | `SUPER + ALT + L` | `CTRL + ALT + SHIFT + L` |
| Mostrar paineis | `SUPER + K` | `SUPER + SHIFT + N` |
| Pin | `SUPER + P` | `SUPER + ALT + P` |
| Arrastar/redimensionar (alias) | `SUPER + Z` / `SUPER + X` | `CTRL + SUPER + LMB/RMB` |
| Launcher no duplo `SUPER` | `SUPER + SUPER_L` | removido (so `SUPER + Space`) |

## Diferencas em relacao ao lyne-dots

- `SUPER + B` no lyne abre um seletor de wallpaper; o Caelestia nao tem esse
  drawer, entao o bind sorteia um wallpaper (`caelestia wallpaper -r`).
- `SUPER + /` (ajuda de atalhos) nao existe no Caelestia e ficou de fora.
- A troca de workspace usa a logica do Caelestia (grupos de 10 por monitor),
  nao o `workspace-manager.sh` do lyne.
