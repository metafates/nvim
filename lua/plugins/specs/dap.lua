local function setup_notifier()
	local ID = "notifier"

	require("dap").listeners.after.event_initialized[ID] = function(session, body)
		vim.notify("Debug session started", vim.log.levels.INFO)
	end
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
	},
	keys = {
		{
			"<leader>cdb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "toggle breakpoint",
		},
		{
			"<leader>cdc",
			function()
				require("dap").continue()
			end,
			desc = "debug continue",
		},
		{
			"<leader>cdr",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "debug run to cursor",
		},
		{
			"<leader>cde",
			function()
				require("dap").close()
			end,
			desc = "debug exit",
		},
		{
			"<leader>cdl",
			function()
				require("dap").step_over()
			end,
			desc = "debug step over",
		},
		{
			"<leader>cdj",
			function()
				require("dap").step_into()
			end,
			desc = "Debug step into",
		},
		{
			"<leader>cdk",
			function()
				require("dap").step_out()
			end,
			desc = "debug step out",
		},
		{
			"<leader>cds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "debug scopes",
		},
		{
			"<leader>cdR",
			function()
				require("dap").repl.toggle()
			end,
			desc = "debug REPL toggle",
		},
	},
	config = function()
		require("dap-go").setup()
		setup_notifier()
	end,
}
