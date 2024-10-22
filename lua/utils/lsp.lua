local M = {}

---@param action string
function M.apply_code_action_sync(action)
	local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
	params.context = { only = { action } }

	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)

	for _, res in pairs(result or {}) do
		if res.error ~= nil then
			local msg = string.format("Failed to apply %q: %s", action, res.error)
			require("utils.notify").add(msg, { level = "ERROR" })
		else
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(0))
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end
end

-- Open LSP picker for the given scope
---@param scope "declaration" | "definition" | "document_symbol" | "implementation" | "references" | "type_definition" | "workspace_symbol"
---@param autojump boolean? If there is only one result it will jump to it.
function M.picker(scope, autojump)
	---@return string
	local function get_symbol_query()
		return vim.fn.input("Symbol: ")
	end

	if not autojump then
		local opts = { scope = scope }

		if scope == "workspace_symbol" then
			opts.symbol_query = get_symbol_query()
		end

		require("mini.extra").pickers.lsp(opts)
		return
	end

	---@param opts vim.lsp.LocationOpts.OnList
	local function on_list(opts)
		vim.fn.setqflist({}, " ", opts)

		if #opts.items == 1 then
			vim.cmd.cfirst()
		else
			require("mini.extra").pickers.list({ scope = "quickfix" }, { source = { name = opts.title } })
		end
	end

	if scope == "references" then
		vim.lsp.buf.references(nil, { on_list = on_list })
		return
	end

	if scope == "workspace_symbol" then
		vim.lsp.buf.workspace_symbol(get_symbol_query(), { on_list = on_list })
		return
	end

	vim.lsp.buf[scope]({ on_list = on_list })
end

return M
