return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	keys = {
		{
			"<leader>B",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<leader>cdc",
			function()
				require("dap").continue()
				require("dapui").open()
			end,
			desc = "Debug continue",
		},
		{
			"<leader>cde",
			function()
				require("dap").stop()
				require("dapui").close()
			end,
		},
		{
			"<leader>cds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "Debug scopes",
		},
		{
			"<leader>cdr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Debug toggle REPL",
		},
		{
			"<leader>cdK",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Debug hover",
		},
	},
	config = function()
		require("dap-go").setup()

		---@diagnostic disable-next-line: missing-fields
		require("dapui").setup({
			layouts = {
				{
					elements = {
						{
							id = "breakpoints",
							size = 0.5,
						},
						{
							id = "stacks",
							size = 0.5,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
		})
	end,
}
