local M = {}

function M.paste()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end

---@param contents string
---@param notify boolean?
function M.copy(contents, notify)
	vim.fn.setreg("+", contents)

	if notify then
		local n = require("mini.notify")

		local id = n.add(string.format("Copied %q", contents))

		vim.defer_fn(function()
			n.remove(id)
		end, 1000)
	end
end

return M
