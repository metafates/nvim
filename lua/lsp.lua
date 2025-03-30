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

vim.lsp.enable({ "gopls", "lua_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
			desc = "Go organize imports on save",
			pattern = { "*.go" },
			callback = function()
				local params = vim.tbl_extend(
					"force",
					vim.lsp.util.make_range_params(nil, "utf-8"),
					{ context = { only = { "source.organizeImports" } } }
				)

				local result = client:request_sync("textDocument/codeAction", params, 3000)

				for _, res in pairs(result or {}) do
					if res.error == nil then
						for _, r in pairs(res.result or {}) do
							if r.edit then
								vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
							else
								client:exec_cmd(r.command)
							end
						end
					end
				end
			end,
		})

		if client:supports_method('textDocument/foldingRange') then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
		end

		if client:supports_method("textDocument/completion") then
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

			for lhs, rhs in pairs({
				["<tab>"] = "<c-y>",
				["<c-j>"] = "<c-n>",
				["<c-k>"] = "<c-p>",
				["<cr>"] = function() return "<c-e>" .. MiniPairs.cr() end,
			}) do
				vim.keymap.set("i", lhs, function()
					if vim.fn.pumvisible() ~= 0 then
						if type(rhs) == "function" then
							return rhs()
						end

						return rhs
					end

					return lhs
				end, { expr = true, buffer = args.buf })
			end
		end

		if
			not client:supports_method("textDocument/willSaveWaitUntil")
			and client:supports_method("textDocument/formatting")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})



vim.diagnostic.config({
	virtual_text = true,
	-- virtual_lines = {
	-- 	current_line = true
	-- }
})
