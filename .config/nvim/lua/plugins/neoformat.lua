return {
  'sbdchd/neoformat',
  config = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.html' },
      command = 'Neoformat',
    })
  end,
}
