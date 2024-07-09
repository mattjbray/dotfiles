return {
  "neovim/nvim-lspconfig",
  init = function()
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup({})
    lspconfig.ocamllsp.setup({})
  end
}
