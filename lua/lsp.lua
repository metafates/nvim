vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
	root_markers = { ".git" },
})

-- load all lsp configs from lsp/
for path in vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath("config"), "lsp")) do
	local name = vim.fn.fnamemodify(path, ":t:r")
	vim.lsp.enable(name)
end

vim.diagnostic.config({
	virtual_text = true,
	-- virtual_lines = {
	-- 	current_line = true
	-- }
})
