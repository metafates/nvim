vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.hl.on_yank() end
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		MiniTrailspace.trim_last_lines()
		MiniTrailspace.trim()
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
			desc = "Go organize imports on save",
			pattern = { "*.go" },
			callback = function()
				require("util.lsp").exec_code_action(client, "source.organizeImports")
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
