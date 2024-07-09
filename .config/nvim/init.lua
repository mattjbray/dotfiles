require("config.lazy")

vim.keymap.set("n", "<LEADER>fed", ":e $MYVIMRC<CR>", { desc = "Edit init.lua" })
vim.keymap.set("n", "<LEADER>qq", ":qa<CR>", { desc = "Quit nvim" })
vim.keymap.set("n", "<LEADER>bd", ":bd<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<LEADER>cl", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<LEADER>cl", "gc", { remap = true, desc = "Comment selection" })

vim.keymap.set("n", "<LEADER>mgg", vim.lsp.buf.definition, { desc = "LSP definition" })
vim.keymap.set("n", "<LEADER>mgt", vim.lsp.buf.type_definition, { desc = "LSP type definition" })
