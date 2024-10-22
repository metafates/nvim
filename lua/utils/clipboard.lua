local M = {}

function M.paste()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end

---@param contents string
---@param notify boolean?
function M.copy(contents, notify)
	vim.fn.setreg("+", contents)

	if notify then
		require("utils.notify").add(string.format("Copied %q", contents), { duration = 1000 })
	end
end

return M
