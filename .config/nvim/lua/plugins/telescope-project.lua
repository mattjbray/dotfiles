return {
  'nvim-telescope/telescope-project.nvim',
  config = function()
    require('telescope').setup {
      extensions = {
        project = {
          hidden_files = true,
        },
      },
    }
    require('telescope').load_extension 'project'
  end,
  lazy = false,
}
