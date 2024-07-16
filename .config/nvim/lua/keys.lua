local M = {}

M.setup = function()
  local tb = require 'telescope.builtin'

  vim.keymap.set('n', '<leader>bb', tb.buffers, { desc = 'Open buffers (telescope)' })

  vim.keymap.set('n', '<leader>fed', ':exe "cd" stdpath("config")<CR>:e $MYVIMRC<CR>', { desc = 'Edit $MYVIMRC' })
  vim.keymap.set('n', '<leader>fek', ':exe "cd" stdpath("config")<CR>:e lua/keys.lua<CR>', { desc = 'Edit keys.lua' })

  vim.keymap.set('n', '<leader>fr', tb.oldfiles, { desc = 'Recent files (telescope)' })

  vim.keymap.set('n', '<leader>sc', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

  local wincmds = {
    { key = 's', desc = 'Split window horizontally' },
    { key = 'v', desc = 'Split window vertically' },
    { key = 'n', desc = 'New window' },
    { key = 'c', as = 'd', desc = 'Close window' },
    { key = 'o', desc = 'Close other windows' },

    { key = 'h', desc = 'Move cursor to left window' },
    { key = 'j', desc = 'Move cursor to window below' },
    { key = 'k', desc = 'Move cursor to window above' },
    { key = 'l', desc = 'Move cursor to right window' },
    { key = 'p', desc = 'Move cursor to previous window' },

    { key = 'r', desc = 'Rotate windows downwards/rightwards' },
    { key = 'R', desc = 'Rotate windows upwards/leftwards' },
    { key = 'x', desc = 'Swap window with next' },

    { key = 'T', desc = 'Break window to a new tab' },
    { key = 'H', desc = 'Move window to far left' },
    { key = 'L', desc = 'Move window to far right' },
    { key = 'J', desc = 'Move window to top' },
    { key = 'K', desc = 'Move window to bottom' },

    { key = '=', desc = 'Make all windows equally high and wide' },
  }

  for _, entry in pairs(wincmds) do
    local as = entry.as or entry.key
    vim.keymap.set('n', '<leader>w' .. as, ':wincmd ' .. entry.key .. '<CR>', { desc = entry.desc })
  end

  vim.keymap.set('n', '<leader>pp', ':Telescope projects<CR>', { desc = 'Projects (telescope)' })
end

return M
