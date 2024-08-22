return {
	"CRAG666/code_runner.nvim",
	keys = {
		{ "<leader>cr", ":RunCode<CR>", desc = "Run code" },
	},
	opts = {
		hot_reload = false,
		focus = false,
		filetype = {
			go = "go run",
		},
	},
}
