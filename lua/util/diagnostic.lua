local M = {}

--- Returns diagnostics under cursor concatenated by newlines
---@return string
function M.get_under_cursor()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row = cursor_pos[1] - 1 -- Convert to 0-indexed
	local col = cursor_pos[2]

	local diagnostics = vim.diagnostic.get(0, { lnum = row })

	local messages = {}
	for _, diagnostic in ipairs(diagnostics) do
		if col >= diagnostic.col and col < (diagnostic.end_col or (diagnostic.col + 1)) then
			local message = diagnostic.message

			if message then
				table.insert(messages, message)
			end
		end
	end

	return table.concat(messages, "\n")
end

return M
