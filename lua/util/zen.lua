local M = {}

local prev = {
	o = {},
	g = {},
}

local PADDING = 70

local zen = {
	o = {
		nu = false,
		rnu = false,
		showtabline = 0,
		cmdheight = 0,
		signcolumn = "no",
		laststatus = 0,
		cursorline = false,
		cursorcolumn = false,
		foldcolumn = "0",
		list = false,
		ruler = false,
		showcmd = false,
		linespace = 5,
	},
	g = {
		neovide_scale_factor = 1.3,
		neovide_padding_top = PADDING,
		neovide_padding_bottom = PADDING,
		neovide_padding_right = PADDING,
		neovide_padding_left = PADDING,
		neovide_opacity = 1,
		transparency = 1,
		neovide_window_blurred = false,
	},
}

function M.toggle()
	if not vim.g.zen then
		for name, value in pairs(zen.o) do
			prev.o[name] = vim.o[name]
			vim.o[name] = value
		end

		for name, value in pairs(zen.g) do
			prev.g[name] = vim.g[name]
			vim.g[name] = value
		end
	else
		for name, value in pairs(prev.o) do
			vim.o[name] = value
		end

		for name, value in pairs(prev.g) do
			vim.g[name] = value
		end
	end

	vim.g.zen = not vim.g.zen
end

return M
