-- Extra plugins which do not fall under any particular category

return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			settings = {
				save_on_toggle = true,
			},
		},
		keys = {
			{
				"<leader>a",
				function()
					require("utils.harpoon").list():add()
					require("utils.notify").add("Added to harpoon", { duration = 1000 })
				end,
				desc = "Harpoon add",
			},
			{
				"<leader>l",
				function()
					require("harpoon").ui:toggle_quick_menu(require("utils.harpoon"):list())
				end,
				desc = "Harpoon list",
			},
			{
				"<leader>h1",
				function()
					require("utils.harpoon"):list():select(1)
				end,
				desc = "Harpoon goto 1",
			},
			{
				"<leader>h2",
				function()
					require("utils.harpoon"):list():select(2)
				end,
				desc = "Harpoon goto 2",
			},
			{
				"<leader>h3",
				function()
					require("utils.harpoon"):list():select(3)
				end,
				desc = "Harpoon goto 3",
			},
			{
				"<leader>h4",
				function()
					require("utils.harpoon"):list():select(4)
				end,
				desc = "Harpoon goto 4",
			},
			{
				"<leader>hc",
				function()
					require("utils.harpoon").list():clear()
					require("utils.notify").add("Harpoon list cleared", { duration = 1000 })
				end,
				desc = "Harpoon clear list",
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
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"fredrikaverpil/neotest-golang",
			"rouge8/neotest-rust",
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
				"<leader>td",
				function()
					---@diagnostic disable-next-line: missing-fields
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Re-run last test",
			},
			{
				"<leader>tS",
				function()
					local neotest = require("neotest")
					neotest.run.stop(neotest.run.get_last_run())
				end,
				desc = "Stop last test",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Show test summary",
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Show test output panel",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, last_run = true, auto_close = true })
				end,
				desc = "Show last test output",
			},
		},
		config = function(_, opts)
			opts = vim.tbl_deep_extend("force", opts, {
				adapters = {
					require("neotest-golang")({
						go_test_args = {
							"-v",
							"-race",
							"-tags=integration",
						},
						go_list_args = { "-tags=integration" },
						dap_go_opts = {
							delve = {
								build_flags = { "-tags=integration" },
							},
						},
					}),
					require("neotest-rust"),
				},
			})

			require("neotest").setup(opts)
		end,
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile", "RunProject" },
		keys = {
			{
				"<leader>R",
				function()
					require("code_runner").run_code()
				end,
				desc = "Run code",
			},
		},
		opts = {
			filetype = {
				go = "go run",
			},
		},
	},
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		opts = {
			attach_navic = false,
			create_autocmd = false,
			exclude_filetypes = { "netrw", "toggleterm", "ministarter" },
		},
	},
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"E",
				function()
					require("nvim-navbuddy").open()
				end,
				desc = "Toggle navbuddy",
			},
		},
		opts = function()
			local actions = require("nvim-navbuddy.actions")

			return {
				window = {
					size = "80%",
				},
				mappings = {
					["E"] = actions.close(),
					["e"] = actions.close(),
				},
			}
		end,
	},
	{
		"ibhagwan/fzf-lua",
		opts = {
			"borderless",
			winopts = { fullscreen = true },
			defaults = { git_icons = true, file_icons = true },
		},
	},
}
