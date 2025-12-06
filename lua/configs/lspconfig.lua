local nvchad_config = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls", "ts_ls", "biome", "tailwindcss" }

for _, name in ipairs(servers) do
  local opts = {
    on_attach = nvchad_config.on_attach,
    on_init = nvchad_config.on_init,
    capabilities = nvchad_config.capabilities,
  }

  vim.lsp.config(name, opts)

  vim.lsp.enable(name)
end
