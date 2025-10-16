MiniDeps.add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_checkout = function()
			vim.cmd.TSUpdate()
		end,
	},
})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
})
