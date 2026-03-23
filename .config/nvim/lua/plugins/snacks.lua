return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = {},
    dashboard = {
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 0, padding = 1 },
        {
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = 1,
        },
        {
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 1,
        },
        { section = 'startup' },
      },
    },
    explorer = {},
    gitbrowse = {},
    picker = {
      actions = {
        parent_dir = function(picker)
          picker:set_cwd(vim.fn.fnamemodify(picker:cwd(), ':h'))
          picker:find()
        end,
        child_dir = function(picker, item)
          if item and item.file then
            local first = item.file:match('^([^/]+)')
            if first then
              picker:set_cwd(picker:cwd() .. '/' .. first)
              picker:find()
            end
          end
        end,
      },
      sources = {
        explorer = {
          hidden = true,
        },
        files = {
          hidden = true,
          win = {
            input = {
              keys = {
                ['<c-h>'] = { 'parent_dir', mode = { 'i', 'n' } },
                ['<c-l>'] = { 'child_dir', mode = { 'i', 'n' } },
              },
            },
          },
        },
      },
    },
    scope = {},
    words = {
      debounce = 100,
    },
  },
  keys = {
    {
      '<leader><space>',
      function()
        require('snacks').picker()
      end,
      desc = 'Pickers (snacks.picker)',
    },
    {
      '<leader>bb',
      function()
        require('snacks').picker.buffers()
      end,
      desc = 'Buffers (snacks.picker.buffers)',
    },
    {
      '<leader>bd',
      function()
        require('snacks').bufdelete.delete()
      end,
      desc = 'Delete this buffer (snacks.bufdelete)',
    },
    {
      '<leader>bh',
      function()
        require('snacks').dashboard()
      end,
      desc = 'Open snacks dashboard (snacks.dashboard)',
    },
    {
      '<leader>bo',
      function()
        require('snacks').bufdelete.other()
      end,
      desc = 'Delete all other buffers (snacks.bufdelete)',
    },
    {
      '<leader>bsn',
      function()
        require('snacks').scratch()
      end,
      desc = 'New scratch buffer (snacks.scratch)',
    },
    {
      '<leader>bss',
      function()
        require('snacks').scratch.select()
      end,
      desc = 'Select scratch buffer (snacks.scratch.select)',
    },
    {
      '<leader>fe',
      function()
        require('snacks').explorer()
      end,
      desc = 'Open snacks explorer (snacks.explorer)',
    },
    {
      '<leader>fE',
      function()
        require('snacks').explorer.reveal()
      end,
      desc = 'Reveal current file in snacks explorer (snacks.explorer.reveal)',
    },
    {
      '<leader>ff',
      function()
        require('snacks').picker.files {
          hidden = true,
          cwd = vim.fn.expand '%:p:h',
        }
      end,
      desc = 'Files (buffer directory) (snacks.picker.files)',
    },
    {
      '<leader>fr',
      function()
        require('snacks').picker.recent()
      end,
      desc = 'Recent (snacks.picker.recent)',
    },
    {
      '<leader>hh',
      function()
        require('snacks').picker.help()
      end,
      desc = 'Help (snacks.help)',
    },
    {
      '<leader>mgg',
      function()
        require('snacks').picker.lsp_definitions()
      end,
      desc = 'Go to definition (snacks.picker.lsp_definitions)',
    },
    {
      '<leader>mgd',
      function()
        require('snacks').picker.lsp_declarations()
      end,
      desc = 'Go to declaration (snacks.picker.lsp_declarations)',
    },
    {
      '<leader>mgr',
      function()
        require('snacks').picker.lsp_references()
      end,
      desc = 'References (snacks.picker.lsp_references)',
    },
    {
      '<leader>mgt',
      function()
        require('snacks').picker.lsp_type_definitions()
      end,
      desc = 'Type definitions (snacks.picker.lsp_type_definitions)',
    },
    {
      '<leader>gl',
      function()
        require('snacks').gitbrowse()
      end,
      desc = 'Git browse (snacks.gitbrowse)',
    },
    {
      '<leader>pf',
      function()
        require('snacks').picker.files {
          hidden = true,
        }
      end,
      desc = 'Project files (snacks.picker.files)',
    },
    {
      '<leader>pp',
      function()
        require('snacks').picker.projects()
      end,
      desc = 'Projects (snacks.picker.projects)',
    },
    {
      '<leader>sf',
      function()
        require('snacks').picker.grep {
          hidden = true,
          cwd = vim.fn.expand '%:p:h',
        }
      end,
      desc = 'Grep (buffer directory) (snacks.picker.grep)',
    },
    {
      '<leader>sF',
      function()
        require('snacks').picker.grep_word {
          hidden = true,
          cwd = vim.fn.expand '%:p:h',
        }
      end,
      mode = { 'n', 'x' },
      desc = 'Grep word (buffer directory) (snacks.picker.grep_word)',
    },
    {
      '<leader>sp',
      function()
        require('snacks').picker.grep {
          hidden = true,
        }
      end,
      desc = 'Grep project (snacks.picker.grep)',
    },
    {
      '<leader>sP',
      function()
        require('snacks').picker.grep_word {
          hidden = true,
        }
      end,
      mode = { 'n', 'x' },
      desc = 'Grep word project (snacks.picker.grep_word)',
    },
  },
}
