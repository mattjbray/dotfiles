require("config.lazy")

require("config.imandra")

vim.keymap.set("n", "<LEADER>fed", ":e $MYVIMRC<CR>", { desc = "Edit init.lua" })
vim.keymap.set("n", "<LEADER>qq", ":qa<CR>", { desc = "Quit nvim" })

vim.keymap.set("n", "<LEADER>ws", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<LEADER>wv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<LEADER>wd", ":close<CR>", { desc = "Delete window" })

vim.keymap.set("n", "<LEADER>bd", ":bd<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<LEADER>cl", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<LEADER>cl", "gc", { remap = true, desc = "Comment selection" })

vim.keymap.set("n", "<LEADER>mgg", vim.lsp.buf.definition, { desc = "LSP definition" })
vim.keymap.set("n", "<LEADER>mgt", vim.lsp.buf.type_definition, { desc = "LSP type definition" })

vim.keymap.set("n", "<LEADER>sc", ":nohl<CR>", { desc = "Clear search highlight" })
