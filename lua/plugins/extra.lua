-- Extra plugins which do not fall under any particular category

return {
	{
		"akinsho/toggleterm.nvim",
		pin = true,
		keys = {
			{ [[<C-p>]], ":ToggleTerm" },
		},
		opts = {
			open_mapping = [[<C-p>]],
			autochdir = true,
			direction = "tab",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		pin = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			settings = {
				save_on_toggle = true,
			},
		},
		config = function(_, opts)
			local harpoon = require("harpoon")
			local extensions = require("harpoon.extensions")

			harpoon:setup(opts)
			harpoon:extend(extensions.builtins.navigate_with_number())
		end,
	},
	{
		"nvim-neotest/neotest",
		pin = true,
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"fredrikaverpil/neotest-golang",
		},
		opts = {
			-- See all config options with :h neotest.Config
			discovery = {
				-- Drastically improve performance in ginormous projects by
				-- only AST-parsing the currently opened buffer.
				enabled = false,
				-- Number of workers to parse files concurrently.
				-- A value of 0 automatically assigns number based on CPU.
				-- Set to 1 if experiencing lag.
				concurrent = 1,
			},
			running = {
				-- Run tests concurrently when an adapter provides multiple commands to run.
				concurrent = true,
			},
			summary = {
				-- Enable/disable animation of icons.
				animated = false,
			},
		},
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Re-run last test",
			},
			{
				"<leader>ts",
				function()
					local neotest = require("neotest")
					neotest.run.stop(neotest.run.get_last_run())
				end,
				desc = "Stop last test",
			},
		},
		config = function(_, opts)
			opts = vim.tbl_deep_extend("force", opts, {
				adapters = {
					require("neotest-golang")({
						go_test_args = {
							"-v",
							"-race",
						},
					}),
				},
			})

			require("neotest").setup(opts)
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
		keys = {
			{

				"<leader>w",
				function()
					for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
						require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
					end
				end,
				desc = "Populate workspace diagnostics",
			},
		},
	},
}
