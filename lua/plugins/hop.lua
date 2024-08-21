return {
	"phaazon/hop.nvim",
	branch = "v2",
	config = function()
		local hop = require("hop")
		hop.setup({ keys = "etovxqpdygfblzhckisuran" })

		vim.keymap.set("", "f", function()
			hop.hint_words({})
		end)
	end,
}
