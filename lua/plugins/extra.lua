-- Extra plugins which do not fall under any particular category

return {
	{
		"akinsho/toggleterm.nvim",
		commit = "137d06fb103952a0fb567882bb8527e2f92d327d",
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
