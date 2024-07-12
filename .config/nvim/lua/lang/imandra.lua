M = {}

M.setup = function(_)
  vim.filetype.add { extension = { iml = 'imandra' } }

  vim.treesitter.language.register('ocaml', 'imandra')

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'imandra',
    callback = function(args)
      vim.lsp.start {
        name = 'imandrax-lsp',
        cmd = { 'imandrax-cli', 'lsp' },
        root_dir = vim.fs.root(args.buf, '.git'),
      }
    end,
  })
end

return M
