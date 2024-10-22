local M = {}

---@alias level "TRACE" | "DEBUG" | "INFO" | "WARN" | "ERROR" | "OFF"

---@class NotifyOpts
---@field duration number?
---@field level level?

---@param msg string Notification message.
---@param opts NotifyOpts?
function M.add(msg, opts)
	opts = opts or {}

	local notify = require("mini.notify")

	local id = notify.add(msg, opts.level)

	vim.defer_fn(function()
		notify.remove(id)
	end, opts.duration or 3000)
end

return M
