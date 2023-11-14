local lspconfig = require("lspconfig")
local config = require("plugins.configs.lspconfig")
local capabilities = config.capabilities
local utils = require("core.utils")

local languages = require("efmls-configs.defaults").languages()

local M = {}

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

lspconfig.pyright.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
  filetypes = { "python" }
})

lspconfig.ruff_lsp.setup({
  on_attach = M.on_attach,
  capabilities = capabilities,
  filetypes = { "python" }
})

lspconfig.taplo.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "toml" }
})

lspconfig.ltex.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  }
}

lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {
  on_attach = M.on_attach,
  capabilities = capabilities
}))


return M
