local M = {}

M.setup = function()
  local keys = {
    ['<leader>'] = {
      keys = {
        a = {
          group = 'Apps',
          keys = {
            t = { require('telescope.builtin').builtin, 'Telescope' },
            d = { '<cmd>DBUI<cr>', 'DBUI (Dadbod)' },
            o = {
              group = 'Neorg',
              keys = {
                o = { '<cmd>Neorg<cr>', 'Neorg' },
                d = {
                  group = 'Journal',
                  keys = { t = { '<cmd>Neorg journal today<cr>', 'today' } },
                },
              },
            },
          },
        },
        b = {
          group = 'Buffers',
          keys = {
            b = {
              require('telescope.builtin').buffers,
              'Open buffers (telescope)',
            },
          },
        },
        e = {
          group = 'Errors (diagnostics)',
          keys = {
            e = { vim.diagnostic.open_float, 'Show diagnostic' },
            l = { vim.diagnostic.setloclist, 'Open diagnostic location list' },
            n = { vim.diagnostic.goto_next, 'Next diagnostic' },
            p = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
            ['<space>'] = {
              require('telescope.builtin').diagnostics,
              'Search diagnostics (telescope)',
            },
          },
        },
        f = {
          group = 'Files',
          keys = {
            e = {
              group = 'Edit',
              keys = {
                d = {
                  '<cmd>exe "cd" stdpath("config")<cr><cmd>e $MYVIMRC<cr>',
                  'Edit $MYVIMRC',
                },
                k = {
                  '<cmd>exe "cd" stdpath("config")<cr><cmd>e lua/keys.lua<cr>',
                  'Edit keys.lua',
                },
              },
            },
            f = {
              '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>',
              'File browser in buffer dir (telescope)',
            },
            r = {
              require('telescope.builtin').oldfiles,
              'Recent files (telescope)',
            },
          },
        },
        g = {
          group = 'Git',
          keys = {
            l = {
              group = 'Link',
              keys = {
                l = { '<cmd>GitLink! browse<cr>', 'Open blob URL' },
                L = { '<cmd>GitLink browse<cr>', 'Copy blob URL' },
                b = { '<cmd>GitLink! blame<cr>', 'Open blame URL' },
                B = { '<cmd>GitLink blame<cr>', 'Copy blame URL' },
              },
            },
          },
        },
        h = {
          group = 'Help',
          keys = {
            h = {
              require('telescope.builtin').help_tags,
              'Browse help (telescope)',
            },
            k = {
              require('telescope.builtin').keymaps,
              'Browse key bindings (telescope)',
            },
          },
        },
        p = {
          group = 'Projects',
          keys = {
            f = {
              function()
                require('telescope.builtin').find_files { hidden = true }
              end,
              'Find files in cwd (telescope)',
            },
            p = { '<cmd>Telescope projects<cr>', 'Projects (telescope)' },
          },
        },
        w = {
          group = 'Window',
          keys = {

            s = { '<cmd>wincmd s<cr>', 'Split window horizontally' },
            v = { '<cmd>wincmd v<cr>', 'Split window vertically' },
            n = { '<cmd>wincmd n<cr>', 'New window' },
            c = { '<cmd>wincmd q<cr>', 'Close window' },
            o = { '<cmd>wincmd o<cr>', 'Close other windows' },

            h = { '<cmd>wincmd h<cr>', 'Move cursor to left window' },
            j = { '<cmd>wincmd j<cr>', 'Move cursor to window below' },
            k = { '<cmd>wincmd k<cr>', 'Move cursor to window above' },
            l = { '<cmd>wincmd l<cr>', 'Move cursor to right window' },
            p = { '<cmd>wincmd p<cr>', 'Move cursor to previous window' },

            r = { '<cmd>wincmd r<cr>', 'Rotate windows downwards/rightwards' },
            R = { '<cmd>wincmd R<cr>', 'Rotate windows upwards/leftwards' },
            x = { '<cmd>wincmd x<cr>', 'Swap window with next' },

            T = { '<cmd>wincmd T<cr>', 'Break window to a new tab' },

            H = { '<cmd>wincmd H<cr>', 'Move window to far left' },
            L = { '<cmd>wincmd L<cr>', 'Move window to far right' },
            J = { '<cmd>wincmd J<cr>', 'Move window to top' },
            K = { '<cmd>wincmd K<cr>', 'Move window to bottom' },

            ['='] = {
              '<cmd>wincmd =<cr>',
              'Make all windows equally high and wide',
            },
          },
        },
        s = {
          group = 'Search',
          keys = {
            c = { '<cmd>nohlsearch<cr>', 'Clear search highlight' },
            g = {
              require('telescope.builtin').live_grep,
              'Live grep (telescope)',
            },
            r = {
              require('telescope.builtin').resume,
              'Resume last search (telescope)',
            },
            w = {
              require('telescope.builtin').grep_string,
              'Search current word',
            },
            ['/'] = {
              function()
                require('telescope.builtin').live_grep {
                  grep_open_files = true,
                  prompt_title = 'Live Grep in Open Files',
                }
              end,
              'Live grep in open files (telescope)',
            },
          },
        },
      },
    },
  }

  local lsp_keys = {
    ['<leader>'] = {
      keys = {
        m = {
          group = 'Lang / Filetype',
          keys = {
            g = {
              group = 'Go to',
              keys = {
                g = {
                  require('telescope.builtin').lsp_definitions,
                  'definition (telescope)',
                },
                r = {
                  require('telescope.builtin').lsp_references,
                  'references (telescope)',
                },
                t = {
                  require('telescope.builtin').lsp_type_definitions,
                  'type definition (telescope)',
                },
              },
            },
            h = {
              group = 'Help',
              keys = {
                h = { vim.lsp.buf.hover, 'Hover Documentation' },
              },
            },
            l = {
              group = 'Code lens',
              keys = {
                r = {
                  function()
                    vim.lsp.codelens.refresh()
                  end,
                  'refresh',
                },
                c = {
                  function()
                    vim.lsp.codelens.clear()
                  end,
                  'clear',
                },
                x = {
                  function()
                    vim.lsp.codelens.execute()
                  end,
                  'execute',
                },
              },
            },
            r = {
              group = 'Refactor',
              keys = {
                n = { vim.lsp.buf.rename, 'rename' },
              },
            },
            s = {
              group = 'Search',
              keys = {
                d = {
                  require('telescope.builtin').lsp_document_symbols,
                  'document symbols (telescope)',
                },
                w = {
                  require('telescope.builtin').lsp_dynamic_workspace_symbols,
                  'workspace symbols (telescope)',
                },
              },
            },
          },
        },
      },
    },
  }

  local map_keys
  map_keys = function(keys_, path)
    for key, data in pairs(keys_) do
      local this_path = (path or '') .. key
      if data.group then
        require('which-key').add { { this_path, group = data.group } }
      end
      if data.keys then
        map_keys(data.keys, this_path)
      end
      if not data.group and not data.keys then
        vim.keymap.set('n', this_path, data[1], { desc = data[2] })
      end
    end
  end

  map_keys(keys)

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('keys-lsp-attach', { clear = true }),
    callback = function()
      map_keys(lsp_keys)
    end,
  })
end

return M
