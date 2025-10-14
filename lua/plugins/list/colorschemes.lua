MiniDeps.add("folke/tokyonight.nvim")
MiniDeps.add("neanias/everforest-nvim")
MiniDeps.add("rebelot/kanagawa.nvim")
MiniDeps.add("wnkz/monoglow.nvim")
MiniDeps.add("jaredgorski/Mies.vim")

require("tokyonight").setup({
	transparent = false,
})

require("everforest").setup({
	background = "soft",
	italics = true,
	show_eob = false,
})

require("kanagawa").setup({})

require("monoglow").setup({})
