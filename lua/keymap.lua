local utils = require("utils")

local map = utils.map

map("n", "0", "^", { noremap = true })

map("n", ";", ":")

map("n", "<Esc>", vim.cmd.nohlsearch)

map("i", "jk", "<Esc>")

map("n", ",w", vim.cmd.wall, "Write all")

map("n", ",q", vim.cmd.quit, "Quit")

map("n", ",Q", function()
	vim.cmd.q({ bang = true })
end, "Quit force")

map("n", ",x", vim.cmd.xa, "Write all and quit")

map("n", ",c", vim.cmd.bd, { silent = true, desc = "Close buffer" })

map("n", ",C", function()
	vim.cmd.bd({ bang = true })
end, { silent = true, desc = "Close buffer force" })

map("n", ",m", function()
	vim.cmd.delm({ bang = true })
	vim.cmd.delm("A-Z0-9")
end, "Delete all marks")

map("n", { "<Tab>", "L" }, vim.cmd.bnext, { silent = true })

map("n", { "<S-Tab>", "H" }, vim.cmd.bprevious, { silent = true })

map("n", "<C-c>", "gcc<DOWN>", { remap = true })

map("v", "<C-c>", "gc", { remap = true })

map("n", "U", vim.cmd.redo, { silent = true })

map({ "n", "x", "v" }, "<leader>y", [["+y]], "Yank selection to clipboard")

map("n", "<leader>f", function()
	require("mini.pick").builtin.files()
end, "Files picker")

map("n", "<leader>F", function()
	local path = vim.api.nvim_buf_get_name(0)

	require("mini.pick").builtin.files(nil, {
		source = { cwd = vim.fs.dirname(path) },
	})
end, "Files in current buffer directory picker")

map("n", "<leader>v", function()
	require("mini.extra").pickers.visit_paths()
end)

map("n", "<leader>s", function()
	require("mini.extra").pickers.lsp({ scope = "document_symbol" })
end, "Document symbols picker")

map("n", "gr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end, "References picker")

map("n", "gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end, "Definitions picker")

map("n", "gD", function()
	require("mini.extra").pickers.lsp({ scope = "type_definition" })
end, "Type definitions picker")

map("n", "gi", function()
	require("mini.extra").pickers.lsp({ scope = "implementation" })
end, "Implementations picker")

map("n", "<leader>/", function()
	require("mini.extra").pickers.buf_lines({ scope = "current" })
end, "Live grep (buffer)")

map("n", "<leader>g", function()
	require("mini.pick").builtin.grep_live()
end, "Live grep (workspace)")

map("n", "<leader><leader>", function()
	require("mini.pick").builtin.resume()
end, "Resume last picker")

map("n", "<leader>m", function()
	require("mini.extra").pickers.marks()
end, "Marks picker")

map("n", "<leader>b", function()
	require("mini.pick").builtin.buffers()
end, "Buffers picker")

map("n", "<leader>d", function()
	require("mini.extra").pickers.diagnostic({ scope = "current" })
end, "Diagnostic picker (buffer)")

map("n", "<leader>D", function()
	require("mini.extra").pickers.diagnostic()
end, "Diagnostic picker (workspace)")

map("n", "T", function()
	local files = require("mini.files")

	if not files.close() then
		files.open(vim.api.nvim_buf_get_name(0))
	end
end)

map("n", "<leader>a", vim.lsp.buf.code_action, "LSP code action")

map("n", "<leader>r", vim.lsp.buf.rename, "LSP rename")

map("n", "f", function()
	local jump2d = require("mini.jump2d")

	jump2d.start(jump2d.builtin_opts.word_start)
end, "Jump 2d")

map("n", "<C-f>", function()
	---@diagnostic disable-next-line: missing-parameter
	require("mini.diff").toggle_overlay()
end, "Toggle diff overlay")

map("n", "gR", function()
	utils.do_diff_hunk_under_cursor("reset")
end, "Reset diff under cursor")

map({ "n", "x", "v" }, "gG", function()
	require("mini.git").show_at_cursor({
		split = "vertical",
	})
end, "Git show at cursor")

map("n", ",o", function()
	utils.close_other_buffers({})
end, "Close other buffers")

map("n", ",O", function()
	utils.close_other_buffers({ "force" })
end, "Close other buffers (force)")

-- https://github.com/chrisgrieser/nvim-spider?tab=readme-ov-file#operator-pending-mode-the-case-of-cw
map("n", "cw", "ce", { remap = true })

map("n", "<leader>cd", function()
	local path = vim.fn.expand("%:p")
	local dirname = vim.fs.dirname(path)

	utils.copy_to_primary_clipboard(dirname, true)
end, "Copy buffer dir path to the clipboard")

map("n", "<leader>cp", function()
	local path = vim.fn.expand("%:p")

	utils.copy_to_primary_clipboard(path, true)
end, "Copy buffer path to the clipboard")

map("i", "<BS>", utils.smart_backspace, {
	expr = true,
	noremap = true,
	replace_keycodes = false,
})

map("i", "<S-BS>", "<BS>")

map({ "n", "x" }, "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
map({ "n", "x" }, "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

map("n", "\\b", function()
	vim.opt.bg = vim.opt.bg == "dark" and "light" or "dark"
end, "Toggle 'background'")
map("n", "\\c", "<cmd>setlocal cursorline! cursorline?<CR>", "Toggle 'cursorline'")
map("n", "\\C", "<cmd>setlocal cursorcolumn! cursorcolumn?<CR>", "Toggle 'cursorcolumn'")
map("n", "\\i", "<cmd>setlocal ignorecase! ignorecase?<CR>", "Toggle 'ignorecase'")
map("n", "\\l", "<cmd>setlocal list! list?<CR>", "Toggle 'list'")
map("n", "\\n", "<cmd>setlocal number! number?<CR>", "Toggle 'number'")
map("n", "\\r", "<cmd>setlocal relativenumber! relativenumber?<CR>", "Toggle 'relativenumber'")
map("n", "\\s", "<cmd>setlocal spell! spell?<CR>", "Toggle 'spell'")
map("n", "\\w", "<cmd>setlocal wrap! wrap?<CR>", "Toggle 'wrap'")

map("n", "<C-h>", "<C-w>h", "Focus on left window")
map("n", "<C-j>", "<C-w>j", "Focus on below window")
map("n", "<C-k>", "<C-w>k", "Focus on above window")
map("n", "<C-l>", "<C-w>l", "Focus on right window")
