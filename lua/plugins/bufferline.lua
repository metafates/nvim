return {
	"akinsho/bufferline.nvim",
	version = "*",
	-- event = { "BufReadPost", "BufNewFile" },
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ ",o", "<cmd>BufferLineCloseOthers<CR>" },
		{ ",p", "<cmd>BufferLineTogglePin<CR>" },
	},
	opts = {
		options = {
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
