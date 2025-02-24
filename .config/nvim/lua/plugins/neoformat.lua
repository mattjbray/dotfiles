return {
  'sbdchd/neoformat',
  keys = {
    {
      '<leader>m=',
      '<cmd>Neoformat<cr>',
      mode = 'n',
      desc = 'Format buffer (neoformat)',
    },
  },
  config = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.html' },
      command = 'Neoformat',
    })
  end,
  enabled = false,
}
