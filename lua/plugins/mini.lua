return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.cursorword").setup()
		require("mini.statusline").setup({
			use_icons = vim.g.have_nerd_font,
		})
		require("mini.starter").setup()
	end,
}
