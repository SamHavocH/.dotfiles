return {
  {
    "nvim-neorg/neorg",
    enabled = false,
    lazy = false,
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/tree-sitter-norg",
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    },
  },
}
