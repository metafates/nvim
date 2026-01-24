local prettier = { "prettierd", "prettier", stop_after_first = true }

MiniDeps.add("stevearc/conform.nvim")

require("conform").formatters.markdownlint = {
	append_args = { "--disable", "MD010" },
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
	},
})
