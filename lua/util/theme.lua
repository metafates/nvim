local M = {}

local PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "theme")

function M.load()
	local ok, lines = pcall(vim.fn.readfile, PATH, "", 1)

	local theme = "retrobox"

	if ok and #lines and lines[1] ~= "" then
		theme = lines[1]
	end

	vim.cmd.colorscheme(theme)
end

function M.write()
	local theme = vim.g.colors_name

	if not theme then
		return
	end

	vim.fn.writefile({ theme }, PATH, "")
end

function M.picker()
	MiniExtra.pickers.colorschemes(nil, {
		source = {
			choose = function(item)
				vim.cmd.colorscheme(item)
				M.write()
			end,
		},
	})
end

return M
