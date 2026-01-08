-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Biome organize imports and format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('user-biome-fix', { clear = true }),
  callback = function(args)
    local clients = vim.lsp.get_clients { name = 'biome', bufnr = args.buf }
    if #clients == 0 then
      return
    end

    pcall(function()
      vim.lsp.buf.code_action {
        context = {
          only = {
            'source.organizeImports.biome' --[[@as any]],
          },
          diagnostics = {},
        },
        apply = true,
      }
    end)

    require('conform').format { bufnr = args.buf, lsp_format = 'fallback' }
  end,
})

-- Open explorer when opening a directory
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end

    vim.cmd.cd(data.file)

    Snacks.explorer {
      layout = { position = 'right' },
    }
  end,
})
