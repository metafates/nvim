return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = "ToggleTerm",
	keys = {
		{ [[<C-\>]], "<cmd>ToggleTerm<cr>" },
	},
	opts = {
		open_mapping = [[<C-\>]],
		direction = "float",
	},
}
