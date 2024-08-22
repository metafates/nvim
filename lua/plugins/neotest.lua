return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-go",
		"nvim-neotest/nvim-nio",
	},
	keys = {
		{
			"<leader>ctf",
			function()
				require("neotest").run.run()
			end,
			desc = "Test function",
		},
		{
			"<leader>cts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test summary",
		},
		{
			"<leader>cto",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Test output panel",
		},
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-go"),
			},
		})
	end,
}
