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
	{
		"chrisgrieser/nvim-spider",
		commit = "b1c542a78522d59432a827f6ec2b28f9422c7e7f",
		opts = {
			subwordMovement = false,
		},
		keys = {
			{
				"w",
				function()
					require("spider").motion("w")
				end,
				mode = { "n", "o", "x" },
			},
			{
				"e",
				function()
					require("spider").motion("e")
				end,
				mode = { "n", "o", "x" },
			},
			{
				"b",
				function()
					require("spider").motion("b")
				end,
				mode = { "n", "o", "x" },
			},
		},
	},
}
