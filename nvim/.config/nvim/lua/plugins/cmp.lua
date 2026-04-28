return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cpm = require("cmp")
    opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })
  end,
}
