M = {}

M.setup = function(_)
  require('lspconfig').pyright.setup {
    autostart = false,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
end

return M
