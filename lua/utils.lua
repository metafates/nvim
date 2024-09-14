local M = {}

---@return {buf_start: integer, buf_count: integer}?
function M.diff_hunk_under_cursor()
	local diff = require("mini.diff")

	local line = unpack(vim.api.nvim_win_get_cursor(0))
	local data = diff.get_buf_data(0)

	if data == nil then
		return nil
	end

	for _, hunk in ipairs(data.hunks) do
		local line_start = hunk.buf_start
		local line_end = line_start + hunk.buf_count

		if line_start <= line and line <= line_end then
			return hunk
		end
	end
end

---@param action "apply" | "reset" | "yank"
function M.do_diff_hunk_under_cursor(action)
	local hunk = M.diff_hunk_under_cursor()

	if hunk == nil then
		return
	end

	local diff = require("mini.diff")

	diff.do_hunks(0, action, {
		line_start = hunk.buf_start,
		line_end = hunk.buf_start + hunk.buf_count,
	})
end

---@param filter fun(buf: integer): boolean
---@param opts vim.api.keyset.buf_delete
function M.close_buffers(filter, opts)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if filter(buf) then
			vim.api.nvim_buf_delete(buf, opts)
		end
	end

	vim.cmd.redrawtabline()
end

---@param opts vim.api.keyset.buf_delete
function M.close_other_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	M.close_buffers(function(buf)
		local is_current = buf == current
		local is_terminal = vim.bo[buf].filetype == "toggleterm"

		return not is_current and not is_terminal
	end, opts)
end

function M.paste_from_primary_clipboard()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end

---@param contents string
---@param notify boolean?
function M.copy_to_primary_clipboard(contents, notify)
	vim.fn.setreg("+", contents)

	if notify then
		local n = require("mini.notify")

		local id = n.add(string.format("Copied %q", contents))

		vim.defer_fn(function()
			n.remove(id)
		end, 1000)
	end
end

---@param action string
function M.apply_code_action(action)
	local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
	params.context = { only = { action } }

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
end

-- Wrapper for vim.keymap.set with support for lhs array
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts vim.keymap.set.Opts?
function M.map(mode, lhs, rhs, opts)
	if type(lhs) == "string" then
		vim.keymap.set(mode, lhs, rhs, opts)
	else
		for _, keys in ipairs(lhs) do
			vim.keymap.set(mode, keys, rhs, opts)
		end
	end
end

-- Define insert mode mappings when popup menu is visible (for completion)
---@param lhs string|string[]
---@param rhs string|function
function M.map_pum(lhs, rhs)
	local mode = "i"
	local opts = { expr = true }

	---@param keys string
	local function map(keys)
		vim.keymap.set(mode, keys, function()
			return vim.fn.pumvisible() ~= 0 and rhs or keys
		end, opts)
	end

	if type(lhs) == "string" then
		map(lhs)
	else
		for _, keys in ipairs(lhs) do
			map(keys)
		end
	end
end

return M
