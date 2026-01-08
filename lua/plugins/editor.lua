return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    opts = { headerMaxWidth = 80 },
    keys = {
      { '<leader>cr', function() require('grug-far').open() end, desc = 'Replace in Project' },
      { '<leader>cw', function() require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } }) end, desc = 'Replace word under cursor' },
      { '<leader>cF', function() require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } }) end, desc = 'Replace in current file' },
    },
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    keys = {
      { '<leader>re', function() require('refactoring').refactor('Extract Function') end, mode = 'x', desc = 'Extract Function' },
      { '<leader>rf', function() require('refactoring').refactor('Extract Function To File') end, mode = 'x', desc = 'Extract Function To File' },
      { '<leader>rv', function() require('refactoring').refactor('Extract Variable') end, mode = 'x', desc = 'Extract Variable' },
      { '<leader>ri', function() require('refactoring').refactor('Inline Variable') end, mode = { 'n', 'x' }, desc = 'Inline Variable' },
      { '<leader>rb', function() require('refactoring').refactor('Extract Block') end, desc = 'Extract Block' },
      { '<leader>rB', function() require('refactoring').refactor('Extract Block To File') end, desc = 'Extract Block To File' },
      { '<leader>rr', function() require('refactoring').select_refactor() end, mode = { 'n', 'x' }, desc = 'Select Refactor' },
    },
  },

  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require 'multicursor-nvim'
      mc.setup()

      local set = vim.keymap.set

      set({ 'n', 'x' }, '<M-c>', function()
        mc.lineAddCursor(1)
      end, { desc = 'Add cursor down' })
      set({ 'n', 'x' }, '<M-C>', function()
        mc.lineAddCursor(-1)
      end, { desc = 'Add cursor up' })

      set({ 'n', 'x' }, '<M-d>', function()
        mc.matchAddCursor(1)
      end, { desc = 'Select next occurrence' })
      set({ 'n', 'x' }, '<M-D>', function()
        mc.matchAddCursor(-1)
      end, { desc = 'Select prev occurrence' })

      set({ 'n', 'x' }, '<M-s>', function()
        mc.matchSkipCursor(1)
      end, { desc = 'Skip and select next' })

      set('n', '<c-leftmouse>', mc.handleMouse)

      set('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          vim.cmd 'noh'
        end
      end)
    end,
  },

  {
    'NMAC427/guess-indent.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next git change' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Prev git change' })

        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset hunk' })

        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'Blame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff against index' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = 'Diff against last commit' })

        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git blame' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'Toggle deleted' })
      end,
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>b', group = 'Buffer', icon = { icon = '󰓩', color = 'cyan' } },
        { '<leader>c', group = 'Code', icon = { icon = '󰅪', color = 'orange' } },
        { '<leader>f', group = 'Find', icon = { icon = '󰈞', color = 'green' } },
        { '<leader>g', group = 'Git', icon = { icon = '󰊢', color = 'orange' } },
        { '<leader>q', group = 'Quit/Session', icon = { icon = '󰗼', color = 'red' } },
        { '<leader>r', group = 'Refactor', icon = { icon = '󰑕', color = 'purple' }, mode = { 'n', 'x' } },
        { '<leader>s', group = 'Search', icon = { icon = '󰍉', color = 'blue' } },
        { '<leader>t', group = 'Toggle', icon = { icon = '󰔡', color = 'yellow' } },
        { '<leader>u', group = 'UI', icon = { icon = '󰙵', color = 'cyan' } },
        { 'gr', group = 'Goto/Refactor', icon = { icon = '󰌹', color = 'purple' } },
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.move').setup {
        mappings = {
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      }

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },

  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'BufReadPost',
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = [[

██████╗ ███████╗███╗   ██╗███████╗██╗   ██╗███╗   ██╗██╗  ██╗
██╔══██╗██╔════╝████╗  ██║╚══███╔╝╚██╗ ██╔╝████╗  ██║╚██╗██╔╝
██████╔╝█████╗  ██╔██╗ ██║  ███╔╝  ╚████╔╝ ██╔██╗ ██║ ╚███╔╝ 
██╔══██╗██╔══╝  ██║╚██╗██║ ███╔╝    ╚██╔╝  ██║╚██╗██║ ██╔██╗ 
██║  ██║███████╗██║ ╚████║███████╗   ██║   ██║ ╚████║██╔╝ ██╗
╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═══╝╚═╝  ╚═╝
]],
          keys = {
            { icon = '󰈞 ', key = 'f', desc = 'Find File', action = ":lua Snacks.picker.files()" },
            { icon = '󰈔 ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = '󰊄 ', key = 'g', desc = 'Find Text', action = ":lua Snacks.picker.grep()" },
            { icon = '󰋚 ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.picker.recent()" },
            { icon = '󰒓 ', key = 'c', desc = 'Config', action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = '󰩈 ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
      },
      explorer = {
        enabled = true,
      },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                position = 'right',
                width = 30,
              },
            },
          },
        },
      },
      lazygit = { enabled = true },
    },
    keys = {
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>e',
        function()
          Snacks.explorer()
        end,
        desc = 'File Explorer',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>uC',
        function()
          local before = vim.g.colors_name
          Snacks.picker.colorschemes({
            live = true,
            confirm = function(picker, item)
              if item then
                local name = item.text or item[1] or item.name or item
                if type(name) == 'table' then name = name.text or name[1] end
                vim.cmd.colorscheme(name)
                local theme_file = vim.fn.stdpath('config') .. '/lua/core/theme.lua'
                local file = io.open(theme_file, 'w')
                if file then
                  file:write('vim.cmd.colorscheme("' .. name .. '")\n')
                  file:close()
                end
              end
              picker:close()
            end,
            cancel = function(picker)
              vim.cmd.colorscheme(before)
              picker:close()
            end,
          })
        end,
        desc = 'Colorscheme Picker',
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
      },
      messages = {
        enabled = true,
      },
      popupmenu = {
        enabled = true,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },
}
