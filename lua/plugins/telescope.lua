return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
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
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
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
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "projects")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "<leader>f", builtin.find_files, { desc = "Search Files" })
		map("n", "<leader>F", function()
			builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
		end, { desc = "Search Files in current buffer directory" })

		map("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
		map("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
		map("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
		map("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
		map("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
		map("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
		map("n", "<leader>sp", telescope.extensions.projects.projects, { desc = "Search Resume" })
		map("n", "<leader>s.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
		map("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

		map("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		map("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Search in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		map("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
