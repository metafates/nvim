return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "T", ":Neotree toggle<CR>", desc = "NeoTree toggle" },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["T"] = "close_window",
				},
			},
		},
	},
}
