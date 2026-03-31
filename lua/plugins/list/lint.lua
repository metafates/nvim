vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
	markdown = { "markdownlint" },
	yaml = { "yamllint" },
	make = { "mbake" },
}

lint.linters.markdownlint.args = {
	"--disable",
	"MD033", -- inline html
	"MD013", -- line length 80
	"MD010", -- hard tabs
	"--stdin",
}
