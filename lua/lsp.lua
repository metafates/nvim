vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
	root_markers = { ".git", ".arc" },
})

vim.lsp.enable({ "gopls", "lua_ls", "bash_ls", "rust_analyzer", "pyright" })

vim.diagnostic.config({
	virtual_text = true,
	-- virtual_lines = {
	-- 	current_line = true
	-- }
})
