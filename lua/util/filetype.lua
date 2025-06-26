local M = {}

--- Returns a list of all known filetypes
---@return string[]
function M.known_filetypes()
	local filetypes = {}

	local glob = vim.fs.joinpath("syntax", "*.vim")

	for _, file in ipairs(vim.api.nvim_get_runtime_file(glob, true)) do
		local name = vim.fn.fnamemodify(file, ":t:r")

		table.insert(filetypes, name)
	end

	table.sort(filetypes)

	return filetypes
end

--- Let a user pick filetype and set selected to the current buffer
function M.select_filetype()
	local filetypes = M.known_filetypes()
	local buf = vim.api.nvim_get_current_buf()

	MiniPick.start({
		source = {
			name = "Select filetype",
			items = filetypes,
			choose = function(item)
				vim.bo[buf].filetype = item
			end,
		},
	})
end

return M
