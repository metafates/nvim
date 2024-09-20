local M = {}

---@param msg string Notification message.
---@param duration number|nil Notification duration in ms. Default 2000 (2 seconds)
---@param level string|nil Notification level as key of |vim.log.levels|.
function M.add(msg, duration, level)
	local notify = require("mini.notify")

	local id = notify.add(msg, level)

	vim.defer_fn(function()
		notify.remove(id)
	end, duration or 2000)
end

return M
