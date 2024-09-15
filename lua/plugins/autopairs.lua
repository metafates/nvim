return {
	"windwp/nvim-autopairs",
	commit = "ffc139f2a96640ca6c4d3dff9b95b7b9eace87ae",
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/nvim-cmp",
			commit = "ae644feb7b67bf1ce4260c231d1d4300b19c6f30",
		},
	},
	config = function()
		require("nvim-autopairs").setup({
			map_bs = false,
		})
		-- If you want to automatically add `(` after selecting a function or method
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
