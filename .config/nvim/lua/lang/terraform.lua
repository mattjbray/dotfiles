M = {}

M.setup = function(_)
  require('lspconfig').terraformls.setup {
    autostart = false,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
end

return M
