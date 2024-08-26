return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = {
		disable_move = true,
		change_to_vcs_root = true,
	},
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
