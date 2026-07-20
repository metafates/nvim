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

return M
