return {
	"nvim-telescope/telescope.nvim",
	-- event = "VimEnter",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	keys = {
		{
			"<leader>f",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<leader>F",
			function()
				require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
			end,
		},
		{
			"<leader>w",
			function()
				require("telescope.builtin").grep_string()
			end,
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules", "mocks" },
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-enter>"] = "to_fuzzy_refine",
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		for _, extension in ipairs({ "fzf", "ui-select", "projects" }) do
			pcall(telescope.load_extension, extension)
		end
	end,
}
