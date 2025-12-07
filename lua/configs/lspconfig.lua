local nvchad_config = require "nvchad.configs.lspconfig"

local default_opts = {
  on_attach = nvchad_config.on_attach,
  on_init = nvchad_config.on_init,
  capabilities = nvchad_config.capabilities,
}

local servers = { "html", "cssls", "ts_ls", "biome", "tailwindcss" }

for _, name in ipairs(servers) do
  vim.lsp.config(name, default_opts)
  vim.lsp.enable(name)
end
