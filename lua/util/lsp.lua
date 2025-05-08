local M = {}

---@param client vim.lsp.Client
---@param action string
---@param timeout_ms integer?
function M.exec_code_action(client, action, timeout_ms)
	local encoding = "utf-8"

	local params =
		vim.tbl_extend("force", vim.lsp.util.make_range_params(nil, encoding), { context = { only = { action } } })

	local result, err = client:request_sync("textDocument/codeAction", params, timeout_ms or 3000)
	if err then
		return
	end

	if not result then
		return
	end

	if result.err then
		return
	end

	for _, r in pairs(result.result or {}) do
		if r.edit then
			vim.lsp.util.apply_workspace_edit(r.edit, encoding)
		else
			client:exec_cmd(r.command)
		end
	end
end

return M
