return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		-- style = "night",
		day_brightness = 0.1,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)

		vim.cmd.colorscheme("tokyonight")

		local cl = vim.api.nvim_get_hl(0, { name = "Folded" })
		vim.api.nvim_set_hl(0, "FoldedText", { bg = cl.bg, italic = true })
		vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
	end,
}

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	priority = 1000,
-- 	opts = {
-- 		background = {
-- 			dark = "wave",
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		require("kanagawa").setup(opts)
--
-- 		vim.cmd.colorscheme("kanagawa")
-- 	end,
-- }

-- return {
-- 	"slugbyte/lackluster.nvim",
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function(_, opts)
-- 		require("lackluster").setup(opts)
--
-- 		vim.cmd.colorscheme("lackluster")
-- 	end,
-- }

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
