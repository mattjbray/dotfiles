return {
  "neovim/nvim-lspconfig",
  enabled = true,
  dependencies = { 'saghen/blink.cmp' },
  lazy = false,
  opts = {
    servers = {
      lua_ls = {},
      ts_ls = {},
    }
  },
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      vim.lsp.enable(server)
      vim.lsp.config(server, config)
    end
  end,

  keys = {
    { "<leader>ma", vim.lsp.buf.code_action, '[R]e[n]ame' },
    { "<leader>mrn", vim.lsp.buf.rename, '[R]e[n]ame' },
  }
}
