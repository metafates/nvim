return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-go",
		"nvim-neotest/nvim-nio",
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

		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-go"),
			},
		})

		require("which-key").add({
			{ "<leader>ct", group = "[C]ode [T]est" },
		})

		local map = vim.keymap.set

		map("n", "<leader>ctf", neotest.run.run, { desc = "[C]ode [T]est [f]unction" })
		map("n", "<leader>ctF", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "[C]ode [T]est [F]ile" })
		map("n", "<leader>ctd", function()
			neotest.run.run(vim.fn.expand("%:p:h"))
		end, { desc = "[C]ode [T]est [D]irectory" })

		map("n", "<leader>cts", neotest.summary.toggle, { desc = "[C]ode [T]est [S]ummary" })
		map("n", "<leader>cto", neotest.output_panel.toggle, { desc = "[C]ode [T]est [O]utput" })
	end,
}
