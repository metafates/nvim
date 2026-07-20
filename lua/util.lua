local H = {}
local M = {}

local section = ""

---@param name string
---@param body sync fun()
function M.section(name, body)
	local old = section

	if section ~= "" then
		section = section .. " > " .. name
	else
		section = name
	end

	local ok, msg = pcall(body)

	if not ok then
		local notification = "failed to load " .. section .. ": " .. msg

		vim.notify(notification, vim.log.levels.ERROR)
	end

	section = old
end

---@param lsp        vim.lsp.Client
---@param actions    string[]
---@param timeout_ms integer?
function M.exec_code_action(lsp, actions, timeout_ms)
	local encoding = "utf-8"

	local params = vim.tbl_extend(
		"force", vim.lsp.util.make_range_params(nil, encoding), { context = { only = actions } }
	)

	local result, err = lsp:request_sync("textDocument/codeAction", params, timeout_ms or 3000)
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
			lsp:exec_cmd(r.command)
		end
	end
end

return M
