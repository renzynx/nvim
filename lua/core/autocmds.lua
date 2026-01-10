vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('user-biome-fix', { clear = true }),
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.json', '*.jsonc', '*.css', '*.graphql' },
  callback = function(args)
    local file = vim.fn.expand('%:p')
    vim.fn.jobstart({ 'biome', 'check', '--write', file }, {
      on_exit = function(_, code)
        if code == 0 then
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              vim.api.nvim_buf_call(args.buf, function()
                vim.cmd('silent! checktime')
              end)
            end
          end)
        end
      end,
    })
  end,
})

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
