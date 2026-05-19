local config_dir = vim.fn.stdpath("config")
local parser_dir = config_dir .. "/parser"
local parser_link = parser_dir .. "/norg.so"
local parser_source = vim.fn.stdpath("data") .. "/lazy-rocks/tree-sitter-norg/lib/lua/5.1/parser/norg.so"

vim.fn.mkdir(parser_dir, "p")

if vim.uv.fs_stat(parser_source) and not vim.uv.fs_stat(parser_link) then
  pcall(vim.uv.fs_symlink, parser_source, parser_link)
end

local add_parser = vim.treesitter.add

if not add_parser and vim.treesitter.language then
  add_parser = vim.treesitter.language.add
end

if vim.uv.fs_stat(parser_link) and add_parser then
  pcall(add_parser, "norg", { path = parser_link })
end
