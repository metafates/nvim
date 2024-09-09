return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		style = "night",
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)

		vim.cmd.colorscheme("tokyonight")
	end,
}

-- return {
-- 	"sainnhe/gruvbox-material",
-- 	priority = 1000,
-- 	init = function()
-- 		vim.opt.background = "dark"
-- 		vim.g.gruvbox_material_enable_italic = true
-- 		vim.g.gruvbox_material_enable_bold = true
--
-- 		-- Available values: 'grey background', 'high contrast background', 'bold', 'underline', 'italic'
-- 		vim.g.gruvbox_material_current_word = "underline"
--
-- 		-- Available values: 'hard', 'medium', 'soft'
-- 		vim.g.gruvbox_material_background = "hard"
--
-- 		vim.cmd.colorscheme("gruvbox-material")
-- 	end,
-- }
