return {
	"folke/todo-comments.nvim",
	event = "BufRead",
	cmd = {
		"TodoTelescope",
		"TodoLocList",
		"TodoQuickFix",
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}
