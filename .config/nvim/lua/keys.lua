local M = {}

M.setup = function()
  local tb = require 'telescope.builtin'

  vim.keymap.set('n', '<LEADER>bb', tb.buffers, { desc = 'Open buffers (telescope)' })

  vim.keymap.set('n', '<LEADER>fed', ':exe "cd" stdpath("config")<CR>:e $MYVIMRC<CR>', { desc = 'Edit $MYVIMRC' })
  vim.keymap.set('n', '<LEADER>fek', ':exe "cd" stdpath("config")<CR>:e lua/keys.lua<CR>', { desc = 'Edit keys.lua' })

  vim.keymap.set('n', '<leader>fr', tb.oldfiles, { desc = 'Recent files (telescope)' })

  vim.keymap.set('n', '<leader>sc', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

  vim.keymap.set('n', '<leader>ws', ':wincmd s<CR>', { desc = 'Split window horizontally' })
  vim.keymap.set('n', '<leader>wv', ':wincmd v<CR>', { desc = 'Split window vertically' })
  vim.keymap.set('n', '<leader>wn', ':wincmd n<CR>', { desc = 'New window' })
  vim.keymap.set('n', '<leader>wc', ':wincmd c<CR>', { desc = 'Close window' })
  vim.keymap.set('n', '<leader>wo', ':wincmd o<CR>', { desc = 'Close other windows' })

  vim.keymap.set('n', '<leader>wh', ':wincmd h<CR>', { desc = 'Move cursor to left window' })
  vim.keymap.set('n', '<leader>wj', ':wincmd j<CR>', { desc = 'Move cursor to window below' })
  vim.keymap.set('n', '<leader>wk', ':wincmd k<CR>', { desc = 'Move cursor to window above' })
  vim.keymap.set('n', '<leader>wl', ':wincmd l<CR>', { desc = 'Move cursor to right window' })
  vim.keymap.set('n', '<leader>wp', ':wincmd p<CR>', { desc = 'Move cursor to previous window' })

  vim.keymap.set('n', '<leader>wr', ':wincmd r<CR>', { desc = 'Rotate windows downwards/rightwards' })
  vim.keymap.set('n', '<leader>wR', ':wincmd R<CR>', { desc = 'Rotate windows upwards/leftwards' })
  vim.keymap.set('n', '<leader>wx', ':wincmd x<CR>', { desc = 'Swap window with next' })

  vim.keymap.set('n', '<leader>wT', ':wincmd T<CR>', { desc = 'Break window to a new tab' })
  vim.keymap.set('n', '<leader>wH', ':wincmd H<CR>', { desc = 'Move window to far left' })
  vim.keymap.set('n', '<leader>wL', ':wincmd L<CR>', { desc = 'Move window to far right' })
  vim.keymap.set('n', '<leader>wJ', ':wincmd J<CR>', { desc = 'Move window to top' })
  vim.keymap.set('n', '<leader>wK', ':wincmd K<CR>', { desc = 'Move window to bottom' })

  vim.keymap.set('n', '<leader>w=', ':wincmd =<CR>', { desc = 'Make all windows equally high and wide' })

  vim.keymap.set('n', '<leader>pp', ':Telescope projects<CR>', { desc = 'Projects (telescope)' })
end

return M
