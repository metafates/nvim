return {
	"windwp/nvim-autopairs",
	pin = true,
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/nvim-cmp",
			pin = true,
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
