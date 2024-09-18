local set = require("utils.keymap").set

set("n", "0", "^", { noremap = true })

set("n", ";", ":")

set("n", "<Esc>", vim.cmd.nohlsearch)

set("i", "jk", "<Esc>")

set("n", ",w", vim.cmd.wall, "Write all")

set("n", ",q", vim.cmd.quit, "Quit")

set("n", ",Q", function()
	vim.cmd.q({ bang = true })
end, "Quit force")

set("n", ",x", vim.cmd.xa, "Write all and quit")

set("n", ",c", vim.cmd.bd, { silent = true, desc = "Close buffer" })

set("n", ",C", function()
	vim.cmd.bd({ bang = true })
end, { silent = true, desc = "Close buffer force" })

set("n", ",m", function()
	vim.cmd.delm({ bang = true })
	vim.cmd.delm("A-Z0-9")
end, "Delete all marks")

set("n", { "<Tab>", "L" }, vim.cmd.bnext, { silent = true })

set("n", { "<S-Tab>", "H" }, vim.cmd.bprevious, { silent = true })

set("n", "<C-c>", "gcc<DOWN>", { remap = true })

set("v", "<C-c>", "gc", { remap = true })

set("n", "U", vim.cmd.redo, { silent = true })

set({ "n", "x", "v" }, "<leader>y", [["+y]], "Yank selection to clipboard")

set("n", "<leader>f", function()
	require("mini.pick").builtin.files()
end, "Files picker")

set("n", "<leader>F", function()
	local path = vim.api.nvim_buf_get_name(0)

	require("mini.pick").builtin.files(nil, {
		source = { cwd = vim.fs.dirname(path) },
	})
end, "Files in current buffer directory picker")

set("n", "<leader>v", function()
	require("mini.extra").pickers.visit_paths()
end)

set("n", "<leader>s", function()
	require("mini.extra").pickers.lsp({ scope = "document_symbol" })
end, "Document symbols picker")

set("n", "gr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end, "References picker")

set("n", "gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end, "Definitions picker")

set("n", "gD", function()
	require("mini.extra").pickers.lsp({ scope = "type_definition" })
end, "Type definitions picker")

set("n", "gi", function()
	require("mini.extra").pickers.lsp({ scope = "implementation" })
end, "Implementations picker")

set("n", "<leader>/", function()
	require("mini.extra").pickers.buf_lines({ scope = "current" })
end, "Live grep (buffer)")

set("n", "<leader>g", function()
	require("mini.pick").builtin.grep_live()
end, "Live grep (workspace)")

set("n", "<leader><leader>", function()
	require("mini.pick").builtin.resume()
end, "Resume last picker")

set("n", "<leader>m", function()
	require("mini.extra").pickers.marks()
end, "Marks picker")

set("n", "<leader>b", function()
	require("mini.pick").builtin.buffers()
end, "Buffers picker")

set("n", "<leader>d", function()
	require("mini.extra").pickers.diagnostic({ scope = "current" })
end, "Diagnostic picker (buffer)")

set("n", "<leader>D", function()
	require("mini.extra").pickers.diagnostic()
end, "Diagnostic picker (workspace)")

set("n", "T", function()
	local files = require("mini.files")

	if not files.close() then
		files.open(vim.api.nvim_buf_get_name(0))
	end
end)

set("n", "<leader>a", vim.lsp.buf.code_action, "LSP code action")

set("n", "<leader>r", vim.lsp.buf.rename, "LSP rename")

set("n", "f", function()
	local jump2d = require("mini.jump2d")

	jump2d.start(jump2d.builtin_opts.word_start)
end, "Jump 2d")

set("n", "<C-f>", function()
	---@diagnostic disable-next-line: missing-parameter
	require("mini.diff").toggle_overlay()
end, "Toggle diff overlay")

set("n", "gR", function()
	require("utils.diff").do_diff_hunk_under_cursor("reset")
end, "Reset diff under cursor")

set({ "n", "x", "v" }, "gG", function()
	require("mini.git").show_at_cursor({
		split = "vertical",
	})
end, "Git show at cursor")

set("n", ",o", function()
	require("utils.buffers").close_other_buffers({})
end, "Close other buffers")

set("n", ",O", function()
	require("utils.buffers").close_other_buffers({ "force" })
end, "Close other buffers (force)")

-- https://github.com/chrisgrieser/nvim-spider?tab=readme-ov-file#operator-pending-mode-the-case-of-cw
set("n", "cw", "ce", { remap = true })

set("n", "<leader>cd", function()
	local path = vim.fn.expand("%:p")
	local dirname = vim.fs.dirname(path)

	require("utils.clipboard").copy(dirname, true)
end, "Copy buffer dir path to the clipboard")

set("n", "<leader>cp", function()
	local path = vim.fn.expand("%:p")

	require("utils.clipboard").copy(path, true)
end, "Copy buffer path to the clipboard")

set("i", "<BS>", require("utils.backspace").smart_backspace, {
	expr = true,
	noremap = true,
	replace_keycodes = false,
})

set("i", "<S-BS>", "<BS>")

set({ "n", "x" }, "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
set({ "n", "x" }, "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

set("n", "\\b", function()
	vim.opt.bg = vim.opt.bg == "dark" and "light" or "dark"
end, "Toggle 'background'")
set("n", "\\c", "<cmd>setlocal cursorline! cursorline?<CR>", "Toggle 'cursorline'")
set("n", "\\C", "<cmd>setlocal cursorcolumn! cursorcolumn?<CR>", "Toggle 'cursorcolumn'")
set("n", "\\i", "<cmd>setlocal ignorecase! ignorecase?<CR>", "Toggle 'ignorecase'")
set("n", "\\l", "<cmd>setlocal list! list?<CR>", "Toggle 'list'")
set("n", "\\n", "<cmd>setlocal number! number?<CR>", "Toggle 'number'")
set("n", "\\r", "<cmd>setlocal relativenumber! relativenumber?<CR>", "Toggle 'relativenumber'")
set("n", "\\s", "<cmd>setlocal spell! spell?<CR>", "Toggle 'spell'")
set("n", "\\w", "<cmd>setlocal wrap! wrap?<CR>", "Toggle 'wrap'")

set("n", "<C-h>", "<C-w>h", "Focus on left window")
set("n", "<C-j>", "<C-w>j", "Focus on below window")
set("n", "<C-k>", "<C-w>k", "Focus on above window")
set("n", "<C-l>", "<C-w>l", "Focus on right window")
