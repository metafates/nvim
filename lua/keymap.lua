local utils = require("utils")

local map = utils.map
local map_pum = utils.map_pum

map_pum({ "<Tab>", "<C-j>" }, "<C-n>")
map_pum({ "<S-Tab>", "<C-k>" }, "<C-p>")

map("n", ";", ":")

map("n", "<Esc>", vim.cmd.nohlsearch)

map("i", "jk", "<Esc>")

map("n", ",w", vim.cmd.wa, { desc = "Write all" })

map("n", ",q", vim.cmd.q, { desc = "Quit" })

map("n", ",Q", function()
	vim.cmd.q({ bang = true })
end, { desc = "Quit force" })

map("n", ",x", vim.cmd.xa, { desc = "Write all and quit" })

map("n", ",c", vim.cmd.bd, { silent = true, desc = "Close buffer" })

map("n", ",C", function()
	vim.cmd.bd({ bang = true })
end, { silent = true, desc = "Close buffer force" })

map("n", { "<Tab>", "L" }, vim.cmd.bnext, { silent = true })

map("n", { "<S-Tab>", "H" }, vim.cmd.bprevious, { silent = true })

map("n", "<C-c>", "gcc<DOWN>", { remap = true })

map("v", "<C-c>", "gc", { remap = true })

map("n", "U", vim.cmd.redo, { silent = true })

map({ "n", "x", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to clipboard" })

map("n", "<leader>f", function()
	require("mini.pick").builtin.files()
end, { desc = "Files picker" })

map("n", "<leader>F", function()
	local path = vim.api.nvim_buf_get_name(0)

	require("mini.pick").builtin.files(nil, {
		source = { cwd = vim.fs.dirname(path) },
	})
end, { desc = "Files in current buffer directory picker" })

map("n", "<leader>v", function()
	require("mini.extra").pickers.visit_paths()
end)

map("n", "<leader>s", function()
	require("mini.extra").pickers.lsp({ scope = "document_symbol" })
end, { desc = "Document symbols picker" })

map("n", "gr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end, { desc = "References picker" })

map("n", "gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end, { desc = "Definitions picker" })

map("n", "gD", function()
	require("mini.extra").pickers.lsp({ scope = "type_definition" })
end, { desc = "Type definitions picker" })

map("n", "gi", function()
	require("mini.extra").pickers.lsp({ scope = "implementation" })
end, { desc = "Implementations picker" })

map("n", "<leader>/", function()
	require("mini.extra").pickers.buf_lines({ scope = "current" })
end, { desc = "Live grep (buffer)" })

map("n", "<leader>g", function()
	require("mini.pick").builtin.grep_live()
end, { desc = "Live grep (workspace)" })

map("n", "<leader><leader>", function()
	require("mini.pick").builtin.resume()
end, { desc = "Resume last picker" })

map("n", "<leader>m", function()
	require("mini.extra").pickers.git_hunks()
end, { desc = "Git hunks picker" })

map("n", "<leader>b", function()
	require("mini.pick").builtin.buffers()
end, { desc = "Buffers picker" })

map("n", "<leader>d", function()
	require("mini.extra").pickers.diagnostic({ scope = "current" })
end, { desc = "Diagnostic picker (buffer)" })

map("n", "<leader>D", function()
	require("mini.extra").pickers.diagnostic()
end, { desc = "Diagnostic picker (workspace)" })

map("n", "T", function()
	local files = require("mini.files")

	if not files.close() then
		files.open(vim.api.nvim_buf_get_name(0))
	end
end)

map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "LSP code action" })

map("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP rename" })

map("n", "f", function()
	local jump2d = require("mini.jump2d")

	jump2d.start(jump2d.builtin_opts.word_start)
end, { desc = "Jump 2d" })

map("n", "<C-f>", function()
	---@diagnostic disable-next-line: missing-parameter
	require("mini.diff").toggle_overlay()
end, { desc = "Toggle diff overlay" })

map("n", "gR", function()
	utils.do_diff_hunk_under_cursor("reset")
end, { desc = "Reset diff under cursor" })

map({ "n", "x", "v" }, "gG", function()
	require("mini.git").show_at_cursor({
		split = "vertical",
	})
end, { desc = "Git show at cursor" })

map("n", ",o", function()
	utils.close_other_buffers({})
end, { desc = "Close other buffers" })

map("n", ",O", function()
	utils.close_other_buffers({ "force" })
end, { desc = "Close other buffers (force)" })

-- https://github.com/chrisgrieser/nvim-spider?tab=readme-ov-file#operator-pending-mode-the-case-of-cw
map("n", "cw", "ce", { remap = true })

map("n", "<leader>cd", function()
	local path = vim.fn.expand("%:p")
	local dirname = vim.fs.dirname(path)

	utils.copy_to_primary_clipboard(dirname, true)
end, { desc = "Copy buffer dir path to the clipboard" })

map("n", "<leader>cp", function()
	local path = vim.fn.expand("%:p")

	utils.copy_to_primary_clipboard(path, true)
end, { desc = "Copy buffer path to the clipboard" })

map("n", "ciw", function()
	require("mini.ai").select_textobject("i", "subword")

	vim.api.nvim_feedkeys("c", "v", false)
end, { remap = true })
