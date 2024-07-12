return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      show_hidden = true,
    }
    require('telescope').load_extension 'projects'
  end,
  keys = {
    { '<leader>pp', ':Telescope projects<CR>', desc = ':Telescope projects' },
  },
}
