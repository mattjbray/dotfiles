local M = {}

M.setup = function()
  require('which-key').add {
    { '<leader>a', group = 'Apps' },
    { '<leader>c', group = '[C]ode' },
    { '<leader>d', group = '[D]ocument' },
    { '<leader>e', group = 'Errors (diagnostics)' },
    { '<leader>f', group = 'Files' },
    { '<leader>g', group = 'Git' },
    { '<leader>h', group = 'Help' },
    { '<leader>m', group = 'Filetype' },
    { '<leader>p', group = 'Projects' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>x', group = 'Touble' },
  }

  vim.keymap.set(
    'n',
    '<leader>at',
    require('telescope.builtin').builtin,
    { desc = 'Telescope' }
  )

  vim.keymap.set(
    'n',
    '<leader>ee',
    vim.diagnostic.open_float,
    { desc = 'Show diagnostic' }
  )
  vim.keymap.set(
    'n',
    '<leader>el',
    vim.diagnostic.setloclist,
    { desc = 'Open diagnostic location list' }
  )
  vim.keymap.set(
    'n',
    '<leader>en',
    vim.diagnostic.goto_next,
    { desc = 'Next diagnostic' }
  )
  vim.keymap.set(
    'n',
    '<leader>ep',
    vim.diagnostic.goto_prev,
    { desc = 'Previous diagnostic' }
  )
  vim.keymap.set(
    'n',
    '<leader>e<space>',
    require('telescope.builtin').diagnostics,
    { desc = 'Search diagnostics (telescope)' }
  )

  vim.keymap.set(
    'n',
    '<leader>bb',
    require('telescope.builtin').buffers,
    { desc = 'Open buffers (telescope)' }
  )

  vim.keymap.set(
    'n',
    '<leader>fed',
    ':exe "cd" stdpath("config")<CR>:e $MYVIMRC<CR>',
    { desc = 'Edit $MYVIMRC' }
  )
  vim.keymap.set(
    'n',
    '<leader>fek',
    ':exe "cd" stdpath("config")<CR>:e lua/keys.lua<CR>',
    { desc = 'Edit keys.lua' }
  )

  vim.keymap.set('n', '<leader>pf', function()
    require('telescope.builtin').find_files { hidden = true }
  end, { desc = 'Search Files in cwd (telescope)' })
  vim.keymap.set(
    'n',
    '<leader>ff',
    '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>',
    { desc = 'File browser in buffer dir (telescope)' }
  )
  vim.keymap.set(
    'n',
    '<leader>fr',
    require('telescope.builtin').oldfiles,
    { desc = 'Recent files (telescope)' }
  )

  vim.keymap.set(
    'n',
    '<leader>hh',
    require('telescope.builtin').help_tags,
    { desc = '[S]earch [H]elp' }
  )
  vim.keymap.set(
    'n',
    '<leader>hk',
    require('telescope.builtin').keymaps,
    { desc = '[S]earch [K]eymaps' }
  )

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('keys-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set(
          'n',
          keys,
          func,
          { buffer = event.buf, desc = 'LSP: ' .. desc }
        )
      end

      require('which-key').add {
        { '<leader>mg', group = 'Go to' },
        { '<leader>mh', group = 'Help' },
        { '<leader>ml', group = 'Code lens' },
        { '<leader>mr', group = 'Refactor' },
        { '<leader>ms', group = 'Search' },
      }

      map(
        '<leader>mgg',
        require('telescope.builtin').lsp_definitions,
        'definitions (telescope)'
      )
      map(
        '<leader>mgr',
        require('telescope.builtin').lsp_references,
        'references (telescope)'
      )
      map(
        '<leader>mgt',
        require('telescope.builtin').lsp_type_definitions,
        'type definition (telescope)'
      )
      map('<leader>mhh', vim.lsp.buf.hover, 'Hover Documentation')
      map('<leader>mrn', vim.lsp.buf.rename, 'rename')
      map(
        '<leader>msd',
        require('telescope.builtin').lsp_document_symbols,
        'document symbols (telescope)'
      )
      map(
        '<leader>msw',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        'workspace symbols (telescope)'
      )

      map('<leader>mlr', function()
        vim.lsp.codelens.refresh()
      end, 'refresh')
      map('<leader>mlc', function()
        vim.lsp.codelens.clear()
      end, 'clear')
      map('<leader>mlx', function()
        vim.lsp.codelens.run()
      end, 'execute')
    end,
  })

  vim.keymap.set(
    'n',
    '<leader>sc',
    '<cmd>nohlsearch<CR>',
    { desc = 'Clear search highlight' }
  )

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
    vim.keymap.set(
      'n',
      '<leader>w' .. as,
      ':wincmd ' .. entry.key .. '<CR>',
      { desc = entry.desc }
    )
  end

  vim.keymap.set(
    'n',
    '<leader>pp',
    ':Telescope projects<CR>',
    { desc = 'Projects (telescope)' }
  )
end

return M
