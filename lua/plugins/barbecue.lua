return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		create_autocmd = false,
	},
	config = function(_, opts)
		require("barbecue").setup(opts)

		vim.api.nvim_create_autocmd({
			"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
			"BufWinEnter",
			"CursorHold",
			"InsertLeave",

			-- include this if you have set `show_modified` to `true`
			"BufModifiedSet",
		}, {
			group = vim.api.nvim_create_augroup("barbecue.updater", {}),
			callback = function()
				require("barbecue.ui").update()
			end,
		})
	end,
}
