-- Extra plugins which do not fall under any particular category

return {
	{
		"akinsho/toggleterm.nvim",
		pin = true,
		keys = {
			{ [[<C-p>]], ":ToggleTerm" },
		},
		opts = {
			open_mapping = [[<C-p>]],
			autochdir = true,
			direction = "tab",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		pin = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			settings = {
				save_on_toggle = true,
			},
		},
		config = function(_, opts)
			local harpoon = require("harpoon")
			local extensions = require("harpoon.extensions")

			harpoon:setup(opts)
			harpoon:extend(extensions.builtins.navigate_with_number())
		end,
	},
}
