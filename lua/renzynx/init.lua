require("renzynx.set")
require("renzynx.remap")
require("renzynx.packer")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


local augroup = vim.api.nvim_create_augroup
local renzynx_group = augroup('renzynx', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})


autocmd({ "BufWritePre" }, {
  group = renzynx_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
