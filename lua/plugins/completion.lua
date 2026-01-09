return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'dsznajder/vscode-es7-javascript-react-snippets',
          build = 'bun install --frozen-lockfile && bun run compile',
        },
      },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    'folke/lazydev.nvim',
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
          },
          components = {
            label_description = {
              width = { max = 50 },
              text = function(ctx)
                -- TypeScript sends import source in 'detail' field, not labelDetails.description
                local item = ctx.item
                if item.detail and item.detail ~= '' then
                  return item.detail
                end
                return ctx.label_description
              end,
              highlight = 'BlinkCmpLabelDescription',
            },
          },
        },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = false },
  },
}
