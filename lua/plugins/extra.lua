local i_dont_care_about_performance = false

return {
	-- Display references, definitions, and implementations of document symbols with a view like JetBrains Idea.
	-- Affects performance when scrolling up for some reason
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		enabled = i_dont_care_about_performance,
		config = function()
			---@diagnostic disable-next-line: missing-parameter
			require("symbol-usage").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ [[<C-\>]], ":ToggleTerm" },
		},
		opts = {
			open_mapping = [[<c-\>]],
			autochdir = true,
			direction = "tab",
		},
	},
}
