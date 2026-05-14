return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,          -- Mostrar por padrão
        hide_dotfiles = false,   -- NÃO esconder arquivos com .
        hide_gitignored = false, -- Mostrar arquivos ignorados pelo git
      },
    },
  },
}
