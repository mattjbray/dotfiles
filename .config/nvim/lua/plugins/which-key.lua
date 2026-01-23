return {
  "folke/which-key.nvim",
  event = "VimEnter",
  keys = {
    {
      '<leader>h?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local keymaps (which-key)',
    },
  },
}
