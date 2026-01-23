return {
  "actionshrimp/gitlad.nvim",
  dir = "~/code/mattjbray/gitlad.nvim",
  config = function()
    require("gitlad").setup({})
  end,
  commands = { "Gitlad" },
  keys = {
    { "<leader>gs", "<cmd>Gitlad<cr>", desc = "Gitlad" },
  },
}
