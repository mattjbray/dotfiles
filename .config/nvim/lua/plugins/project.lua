return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      show_hidden = true,
    }
    require('telescope').load_extension 'projects'
  end,
  lazy = false,
}
