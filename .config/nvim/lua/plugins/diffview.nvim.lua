return {
  'actionshrimp/diffview.nvim',
  branch = '3-way-staging',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  opts = {
    use_icons = false,
  },
  keys = {
    { '<leader>dd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
    {
      '<leader>df',
      '<cmd>DiffviewFileHistory %<cr>',
      desc = 'Diffview File History (current file)',
    },
    {
      '<leader>dl',
      '<cmd>DiffviewFileHistory<cr>',
      desc = 'Diffview File History',
    },
    { '<leader>dc', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
    { '<leader>dr', '<cmd>DiffviewRefresh<cr>', desc = 'Refresh Diffview' },
  },
}
