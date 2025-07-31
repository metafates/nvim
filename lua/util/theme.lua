local M = {}

M.THEMES = { "tokyonight", "retrobox", "everforest", "kanagawa" }

local PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "theme")

function M.load()
	local ok, lines = pcall(vim.fn.readfile, PATH, "", 1)

	local theme = M.THEMES[1]

	if ok and #lines and lines[1] ~= "" then
		theme = lines[1]
	end

	vim.cmd.colorscheme(theme)
end

function M.write()
	local theme = vim.g.colors_name or M.THEMES[1]

	vim.fn.writefile({ theme }, PATH, "")
end

function M.picker()
	MiniPick.start({
		source = {
			name = "Select theme",
			items = M.THEMES,
			choose = function(item)
				vim.cmd.colorscheme(item)
				M.write()
			end,
		},
	})
end

return M
