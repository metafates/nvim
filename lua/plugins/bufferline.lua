return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ ",o", ":BufferLineCloseOthers<CR>" },
		{ ",p", ":BufferLineTogglePin<CR>" },
	},
	opts = {
		options = {
			numbers = "ordinal",
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "neo-tree",
					text = "Files",
					text_align = "center",
					separator = true,
				},
			},
		},
	},
}
