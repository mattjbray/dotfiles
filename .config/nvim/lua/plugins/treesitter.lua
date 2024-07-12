return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "ocaml", "vimdoc", "vim", "lua" },
			highlight = { enable = true },
			indent = { enable = true },
		})

		-- vim.treesitter.language.register('ocaml', 'imandra')
		-- set foldmethod=expr
		-- set foldexpr=nvim_treesitter#foldexpr()
		-- set nofoldenable                     " Disable folding at startup.
	end
}
