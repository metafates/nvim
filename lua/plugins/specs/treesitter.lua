local ensure_installed = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",

	"go",
	"proto",
	"json",
	"yaml",
	"bash",
	"fish"
}

return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0,
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = ensure_installed
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
