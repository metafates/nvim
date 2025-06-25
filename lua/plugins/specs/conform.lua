local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			python = { "black" },
			typst = { "typstyle" },
			markdown = { "markdownlint" },
			json = prettier,
			yaml = prettier,
		},
	},
}
