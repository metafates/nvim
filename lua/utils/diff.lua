local M = {}

---@alias diff_hunk {line_start: integer, line_end: integer}

local H = {}

---@param buf_id integer?
---@return diff_hunk[]
function H.adjacent_diff_hunks(buf_id)
	local diff = require("mini.diff")
	local data = diff.get_buf_data(buf_id or 0)

	if data == nil or #data.hunks == 0 then
		return {}
	end

	---@type diff_hunk?
	local prev_hunk

	---@type diff_hunk[]
	local hunks = {}

	for _, hunk in ipairs(data.hunks) do
		---@type diff_hunk
		local current_hunk

		do
			local line_start = hunk.buf_start
			local line_end = line_start + hunk.buf_count - 1

			current_hunk = { line_start = line_start, line_end = line_end }
		end

		if prev_hunk == nil then
			prev_hunk = current_hunk
		elseif current_hunk.line_start - prev_hunk.line_end == 1 then
			prev_hunk.line_end = current_hunk.line_end
		else
			table.insert(hunks, prev_hunk)

			prev_hunk = current_hunk
		end
	end

	table.insert(hunks, prev_hunk)

	return hunks
end

---@return diff_hunk?
function H.diff_hunk_under_cursor()
	local hunks = H.adjacent_diff_hunks(0)

	local line = unpack(vim.api.nvim_win_get_cursor(0))

	for _, hunk in ipairs(hunks) do
		if hunk.line_start <= line and line <= hunk.line_end then
			return hunk
		end
	end
end

---@param action "apply" | "reset" | "yank"
function M.do_diff_hunk_under_cursor(action)
	local hunk = H.diff_hunk_under_cursor()

	if hunk == nil then
		return
	end

	local diff = require("mini.diff")

	diff.do_hunks(0, action, {
		line_start = hunk.line_start,
		line_end = hunk.line_end,
	})
end

return M
