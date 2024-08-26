return {
	"echasnovski/mini.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.cursorword").setup()
	end,
}
