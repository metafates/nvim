local M = {}

function M.list()
	local detected = require("mini.sessions").detected

	if #detected == 0 then
		return require("harpoon"):list()
	end

	return require("harpoon"):list(detected[1].name)
end

function M.picker()
	local items = vim.iter(M.list().items)
		:map(function(item)
			return { path = item.value, text = item.value }
		end)
		:totable()

	require("mini.pick").start({
		source = {
			name = "Harpoon",
			items = items,
		},
	})
end

return M
