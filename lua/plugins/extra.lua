-- Extra plugins which do not fall under any particular category

return {
	{
		"akinsho/toggleterm.nvim",
		commit = "137d06fb103952a0fb567882bb8527e2f92d327d",
		keys = {
			{ [[<C-\>]], ":ToggleTerm" },
		},
		opts = {
			open_mapping = [[<C-\>]],
			autochdir = true,
			direction = "tab",
		},
	},
	{
		"chrisgrieser/nvim-spider",
		commit = "b1c542a78522d59432a827f6ec2b28f9422c7e7f",
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
	{
		--[[ TODO: replace it with mini.ai if possible
		
	local pattern = {
		"()%w[%l%d]+([_%- ]?)", -- camelCase or lowercase
		"()%u[%u%d]+([_%- ]?)", -- UPPER_CASE
		"()%d+([_%- ]?)", -- number
	}
		--]]
		"chrisgrieser/nvim-various-textobjs",
		commit = "fcdec45b3bf33d3b279d2c5fee06abf4ce152008",
		keys = {
			{
				"ciw",
				function()
					require("various-textobjs").subword("inner")

					vim.api.nvim_feedkeys("c", "v", false)
				end,
				remap = true,
			},
		},
	},
}
