M = {}

M.setup = function(_)
  require('lspconfig').ts_ls.setup {
    autostart = false,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
  require('lspconfig').eslint.setup {
    autostart = false,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
end

return M
