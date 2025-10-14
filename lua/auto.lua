local set = require("util.keymap").set

---@generic T
---@param arr T[]
---@param e T
---@return boolean
local function contains(arr, e)
	for _, v in ipairs(arr) do
		if v == e then
			return true
		end
	end

	return false
end

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		MiniTrailspace.trim_last_lines()
		MiniTrailspace.trim()

		require("conform").format({ bufnr = args.buf, timeout_ms = 500, lsp_format = "fallback" })
		require("lint").try_lint()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		require("lint").try_lint()
	end,
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

		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()

			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end

		if client:supports_method("textDocument/completion") then
			local chars = {}
			for i = 32, 126 do
				local ch = string.char(i)

				if not contains({ " ", '"', "'", "[", "]", "(", ")", "{", "}" }, ch) then
					table.insert(chars, ch)
				end
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

			set("i", "<c-space>", vim.lsp.completion.get)

			for lhs, rhs in pairs({
				["<tab>"] = "<c-y>",
				["<c-j>"] = "<c-n>",
				["<c-k>"] = "<c-p>",
				-- ["<cr>"] = "<c-e>",
				["<cr>"] = function()
					return "<c-e>" .. MiniPairs.cr()
				end,
			}) do
				set("i", lhs, function()
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
	end,
})

vim.api.nvim_create_autocmd({ "TermEnter", "TermOpen" }, {
	callback = function(_)
		vim.opt_local.spell = false
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "minigit://*",
	callback = function(args)
		vim.opt_local.spell = false

		set("n", "q", vim.cmd.bd, { buffer = args.buf })
	end,
})
