return {
  'actionshrimp/direnv.nvim',
  branch = 'main',
  opts = {
    async = true,
    on_direnv_finished = function()
      vim.cmd 'LspStart'
    end,
  },
}
