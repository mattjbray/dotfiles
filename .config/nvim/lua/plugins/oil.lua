return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  opts = {
    view_options = { show_hidden = true },
  },
  keys = {
    { '-', '<cmd>Oil<cr>', { desc = 'Open parent directory (oil)' } },
  },
}
