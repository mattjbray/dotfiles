return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = true,
  init = function()
    local neogit = require('neogit')
    vim.keymap.set('n', '<leader>gs', neogit.open, {})
  end,
}
