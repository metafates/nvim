return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		mode = "cursor",
		max_lines = 3,
	},
}
