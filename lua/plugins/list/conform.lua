local prettier = { "prettierd", "prettier", stop_after_first = true }

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.formatters.markdownlint = {
	append_args = { "--disable", "MD010" },
}

conform.formatters.mbake = {
	command = "mbake",
	args = { "format", "--stdin" },
}

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "black" },
		typst = { "typstyle" },
		markdown = { "markdownlint" },
		typescript = prettier,
		javascript = prettier,
		json = prettier,
		yaml = prettier,
		bib = { "bibtex-tidy" },
		make = { "mbake" },
	},
})
