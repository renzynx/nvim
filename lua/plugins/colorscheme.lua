return {
  {
    'vague2k/huez.nvim',
    import = 'huez-manager.import',
    branch = 'stable',
    lazy = false,
    priority = 1000,
    keys = {
      { '<leader>uC', '<cmd>Huez<cr>', desc = 'Colorscheme Picker' },
      { '<leader>uT', '<cmd>HuezLive<cr>', desc = 'Browse Theme Registry' },
    },
    opts = {
      exclude = {
        'desert', 'evening', 'industry', 'koehler', 'morning', 'murphy',
        'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner',
        'blue', 'darkblue', 'delek', 'quiet', 'elflord', 'habamax',
        'lunaperche', 'zaibatsu', 'wildcharm', 'sorbet', 'vim', 'default',
        'randomhue', 'miniwinter', 'minisummer', 'minispring', 'minischeme',
        'minicyan', 'miniautumn',
      },
    },
  },
}
