return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function ()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
		}
	},
	"neovim/nvim-lspconfig",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true 
	},
}
