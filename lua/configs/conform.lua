local options = {
  formatters_by_ft = {
    -- Use Biome for JS/TS stack
    javascript = { "biome" },
    typescript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
    lua = { "stylua" },

    -- Fallback to prettier for other web files if you want
    css = { "biome" },
    html = { "biome" },
  },

  -- Enable Format on Save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
