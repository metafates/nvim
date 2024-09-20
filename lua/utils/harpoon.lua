local M = {}

-- Gets harpoon list for the current session or anonymous list if session is not detected
---@return HarpoonList
function M.list()
	local detected = require("mini.sessions").detected

	if #detected == 0 then
		return require("harpoon"):list()
	end

	return require("harpoon"):list(detected[1].name)
end

return M
