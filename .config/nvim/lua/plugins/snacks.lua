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
      sources = {
        explorer = {
          hidden = true,
        },
        files = {
          hidden = true,
        },
      },
    },
    scope = {},
    words = {},
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
      '<leader>bd',
      function()
        require('snacks').bufdelete.delete()
      end,
      desc = 'Delete this buffer (snacks.bufdelete)',
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
      '<leader>ff',
      function()
        require('snacks').picker.files {
          hidden = true,
        }
      end,
      desc = 'Files (snacks.picker.files)',
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
      '<leader>pp',
      function()
        require('snacks').picker.projects()
      end,
      desc = 'Projects (snacks.picker.projects)',
    },
  },
}
