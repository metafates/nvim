vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require("nvim-treesitter").install({
	"go",
	"gotmpl",
	"gomod",
	"gowork",
	"gosum",
	"lua",
	"html",
	"xml",
	"json",
	"yaml",
	"toml",
	"markdown",
	"markdown_inline",
})
