return {
  'olrtg/nvim-emmet',
  config = function()
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>xe',
      require('nvim-emmet').wrap_with_abbreviation
    )
    require('lspconfig').emmet_language_server.setup {
      autostart = false,
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }
  end,
}
