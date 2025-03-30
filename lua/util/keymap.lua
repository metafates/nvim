local M = {}


-- Defines a |mapping| of |keycodes| to a function or keycodes.
---@param mode string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs string|string[]  Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts|string Options to pass for keymap. Single string is used as a description
function M.set(mode, lhs, rhs, opts)
	if type(opts) == "string" then
		opts = { desc = opts }
	end

	if type(lhs) == "table" then
		for _, l in pairs(lhs) do
			vim.keymap.set(mode, l, rhs, opts)
		end

		return
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
