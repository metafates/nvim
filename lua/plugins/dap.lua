return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
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
			end,
			desc = "Debug continue",
		},
		{
			"<leader>cdR",
			function()
				require("dap").run_last()
			end,
			desc = "Debug rerun",
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
		require("nvim-dap-virtual-text").setup({})
		require("dap-go").setup()
	end,
}
