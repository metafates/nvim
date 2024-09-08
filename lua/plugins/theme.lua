-- return {
-- 	"folke/tokyonight.nvim",
-- 	priority = 1000,
-- 	init = function()
-- 		vim.cmd.colorscheme("tokyonight-night")
-- 		vim.cmd.hi("Comment gui=none")
-- 	end,
-- }

return {
	"sainnhe/gruvbox-material",
	priority = 1000,
	init = function()
		vim.opt.background = "dark"
		vim.g.gruvbox_material_enable_italic = true

		-- Available values: 'hard', 'medium'(default), 'soft'
		vim.g.gruvbox_material_background = "hard"

		vim.cmd.colorscheme("gruvbox-material")
	end,
}
