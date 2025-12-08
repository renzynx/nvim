local options = {
  formatters_by_ft = {
    javascript = { "biome" },
    typescript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
    lua = { "stylua" },
    css = { "biome" },
    html = { "biome" },
  },

  formatters = {
    biome = {
      args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
