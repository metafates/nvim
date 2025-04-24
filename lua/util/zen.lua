local M = {}


local prev = {}

local zen = {
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
}

function M.toggle()
	if not vim.g.zen then
		for name, value in pairs(zen) do
			prev[name] = vim.o[name]
			vim.o[name] = value
		end
	else
		for name, value in pairs(prev) do
			vim.o[name] = value
		end
	end

	vim.g.zen = not vim.g.zen
end

return M
