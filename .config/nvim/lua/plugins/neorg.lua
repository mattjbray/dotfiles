return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/code/mattjbray/notes',
          },
          default_workspace = 'notes',
        },
      },
      ['core.journal'] = {
        config = {
          journal_folder = 'daily',
          strategy = 'flat',
        },
      },
    },
  },
}
