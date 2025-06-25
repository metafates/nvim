return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
		}

		lint.linters.markdownlint.args = {
			"--disable",
			"MD033", -- inline html
			"MD013", -- line length 80
			"--stdin",
		}
	end,
}
