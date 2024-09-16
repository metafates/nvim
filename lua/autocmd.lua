local utils = require("utils")

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Go organize imports on save",
	pattern = { "*.go" },
	callback = function()
		utils.apply_code_action("source.organizeImports")
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client == nil then
			return
		end

		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
		end

		if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("\\h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end
	end,
})
