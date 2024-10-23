local function setup_notifier()
	local ID = "notifier"

	local dap = require("dap")
	local notify = require("utils.notify")

	dap.listeners.after.event_initialized[ID] = function(session, body)
		notify.add("Debug session started")
	end
end

return {
	"mfussenegger/nvim-dap",
	pin = true,
	dependencies = {
		"leoluz/nvim-dap-go",
	},
	keys = {
		{
			"<leader>cdb",
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
			"<leader>cdr",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Debug run to cursor",
		},
		{
			"<leader>cde",
			function()
				require("dap").close()
			end,
			desc = "Debug exit",
		},
		{
			"<leader>cdl",
			function()
				require("dap").step_over()
			end,
			desc = "Debug step over",
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
			desc = "Debug step out",
		},
		{
			"<leader>cds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "Debug scopes",
		},
	},
	config = function()
		require("dap-go").setup()
		setup_notifier()
	end,
}
