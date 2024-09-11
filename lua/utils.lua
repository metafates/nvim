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
		return buf ~= current
	end, opts)
end

function M.paste_from_primary_clipboard()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end

return M
