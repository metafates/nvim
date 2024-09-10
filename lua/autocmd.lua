vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Import missing packages in Go on save ",
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(0))
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end
	end,
})

vim.api.nvim_create_autocmd("TabNewEntered", {
	nested = true,
	callback = function()
		require("mini.starter").open()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client == nil then
			return
		end

		if client.server_capabilities.completionProvider then
			vim.bo[event.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		end
	end,
})
