return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function()
      return require "configs.conform"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Suggest automatically as you type
          keymap = {
            accept = "<C-l>", -- Ctrl+L
            next = "<M-]>", -- Alt+] to cycle to the next suggestion
            prev = "<M-[>", -- Alt+[ to cycle to the previous suggestion
            dismiss = "<C-]>", -- Ctrl+] to dismiss the suggestion
          },
        },
        panel = {
          enabled = false, -- Disable the bulky side panel
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      }
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter", -- Load when you start typing
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
    },

    config = function(_, opts)
      require("nvim-tree").setup(opts)

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("nvim-tree.api").tree.open {
            focus = false,
            find_file = true,
          }
        end,
      })
    end,
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      require("rainbow-delimiters.setup").setup {
        strategy = {
          [""] = require "rainbow-delimiters.strategy.global",
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "David-Kunz/cmp-npm",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "json", -- Only load when editing package.json
    config = function()
      require("cmp-npm").setup {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "npm", keyword_length = 4 })
    end,
  },

  {

    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Load when LSP is ready
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()

      vim.diagnostic.config { virtual_text = false }
    end,
  },
}
