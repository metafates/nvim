local ensure_installed = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"gitignore",
	"git_config",
	"gitcommit",
	"git_rebase",
	"gitattributes",
	"python",

	"go",
	"gomod",
	"gosum",
	"gowork",
	"gotmpl",

	"proto",
	"json",
	"yaml",
	"toml",
	"bash",
	"fish",
	"rust",
	"sql",
	"ssh_config",
	"typst",

	"dockerfile",

	"html",
	"css",
	"xml",

	"just",
	"make",
}

MiniDeps.add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_checkout = function()
			vim.cmd.TSUpdate()
		end,
	},
})

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = ensure_installed,
})
