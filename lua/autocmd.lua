vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("Lazy vim started", {}),
	pattern = "LazyVimStarted",
	callback = function()
		require("mini.starter").refresh()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("OrganizeImports", {}),
	desc = "Go organize imports on save",
	pattern = { "*.go" },
	callback = function()
		require("utils.lsp").apply_code_action("source.organizeImports")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Test output panel",
	pattern = { "neotest-output-panel" },
	callback = function(event)
		require("utils.keymap").set("n", "q", function()
			local neotest = require("neotest")

			neotest.output_panel.clear()
			neotest.output_panel.close()
		end, { buffer = event.buf })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Quit with q",
	pattern = { "neotest-output", "dap-float" },
	callback = function(event)
		require("utils.keymap").set("n", "q", vim.cmd.quit, { buffer = event.buf })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "DAP UI keys",
	pattern = { "dap-float" },
	callback = function()
		require("utils.keymap").set("n", "t", function()
			require("dap.ui").trigger_actions({ mode = "first" })
		end)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("Adjust LSP keymaps", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client == nil then
			return
		end

		local set = function(lhs, rhs, desc)
			require("utils.keymap").set("n", lhs, rhs, { buffer = event.buf, desc = desc })
		end

		if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			set("\\h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	group = vim.api.nvim_create_augroup("Update env", {}),
	callback = function()
		-- TODO: maybe unload previosly loaded variables?
		require("utils.env").try_load_dotenv()
	end,
})
