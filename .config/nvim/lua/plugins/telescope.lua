return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = true,
  init = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Buffers" })
  end
}
