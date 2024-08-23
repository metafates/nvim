local theme = {
	"folke/tokyonight.nvim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("tokyonight-night")
		vim.cmd.hi("Comment gui=none")
	end,
}

-- local theme = {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = true,
-- 	init = function()
-- 		vim.o.background = "dark" -- or "light" for light mode
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- }

return theme
