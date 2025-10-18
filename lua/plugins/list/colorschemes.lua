MiniDeps.add("folke/tokyonight.nvim")
MiniDeps.add("rebelot/kanagawa.nvim")

require("tokyonight").setup({
	transparent = false,
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
	},
})

require("kanagawa").setup({})
