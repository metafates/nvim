local M = {}

function M.starter_section()
	local section_name = "Sessions"

	return {
		{
			name = string.format("Load session %q", M.name()),
			action = function()
				M.read({ force = true })
			end,
			section = section_name,
		},
		{
			name = "Sessions picker",
			action = function()
				require("mini.sessions").select()
			end,
			section = section_name,
		},
	}
end

---@return string
function M.name()
	local misc = require("mini.misc")

	---@type string
	local name

	do
		local root = misc.find_root()

		if root == nil then
			root = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
		end

		name = vim.fs.basename(root)
	end

	return name
end

---@param opts table?
function M.read(opts)
	require("mini.sessions").read(M.name(), opts)
end

function M.write()
	require("mini.sessions").write(M.name())
end

return M
