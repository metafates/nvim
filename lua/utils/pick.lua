local M = {}

function M.filetype()
	local items = {}

	for _, path in ipairs(vim.api.nvim_get_runtime_file("syntax/*.vim", true)) do
		local filetype = vim.fn.fnamemodify(path, ":t:r")

		table.insert(items, filetype)
	end

	local buf = vim.api.nvim_get_current_buf()

	require("mini.pick").start({
		source = {
			items = items,
			name = "Filetypes",
			choose = function(filetype)
				vim.bo[buf].filetype = filetype
			end,
		},
	})
end

return M
