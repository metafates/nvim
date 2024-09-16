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
}
