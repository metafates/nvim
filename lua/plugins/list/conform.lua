local prettier = { "prettierd", "prettier", stop_after_first = true }

MiniDeps.add("stevearc/conform.nvim")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "black" },
		typst = { "typstyle" },
		markdown = { "markdownlint" },
		json = prettier,
		yaml = prettier,
		bib = { "bibtex-tidy" },
	},
})
