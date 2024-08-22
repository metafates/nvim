return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "BufEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ ",o", ":BufferLineCloseOthers<CR>" },
		{ ",p", ":BufferLineTogglePin<CR>" },
	},
	opts = {
		options = {
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
