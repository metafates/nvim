local map = vim.keymap.set

local function map_pum(lhs, rhs)
	map("i", lhs, function()
		return vim.fn.pumvisible() ~= 0 and rhs or lhs
	end, { expr = true })
end

map_pum("<Tab>", "<C-n>")
map_pum("<C-j>", "<C-n>")

map_pum("<S-Tab>", "<C-p>")
map_pum("<C-k>", "<C-p>")

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("i", "jk", "<Esc>")
map("n", ",w", "<cmd>w<CR>", { desc = "Write" })
map("n", ",q", "<cmd>q<CR>", { desc = "Quit" })
map("n", ",Q", "<cmd>q!<CR>", { desc = "Quit force" })
map("n", ",x", "<cmd>x<CR>", { desc = "Write and quit" })
map("n", ",c", "<cmd>bd<CR>", { silent = true, desc = "Close buffer" })
map("n", ",C", "<cmd>bd!<CR>", { silent = true, desc = "Close buffer force" })

map("n", "L", "<cmd>bnext<CR>", { silent = true })
map("n", "H", "<cmd>bprevious<CR>", { silent = true })

map("n", "<C-c>", "gcc<DOWN>", { remap = true })
map("v", "<C-c>", "gc", { remap = true })

map("n", "U", "<cmd>redo<CR>", { silent = true })

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

map("n", "<leader>m", function()
	require("mini.extra").pickers.git_files({ scope = "modified" })
end, { desc = "Modified git files picker" })

map("n", "<leader><leader>", function()
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
	require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle diff overlay" })

map("n", "gR", function()
	local line = unpack(vim.api.nvim_win_get_cursor(0))

	require("mini.diff").do_hunks(0, "reset", {
		line_start = line,
		line_end = line,
	})
end, { desc = "Reset diff under cursor" })

map({ "n", "x", "v" }, "gG", function()
	require("mini.git").show_at_cursor({
		split = "vertical",
	})
end, { desc = "Git show at cursor" })

local function close_other_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if current ~= buf then
			vim.api.nvim_buf_delete(buf, opts)
		end
	end

	vim.cmd.redrawtabline()
end

map("n", ",o", function()
	close_other_buffers({})
end, { desc = "Close other buffers" })

map("n", ",O", function()
	close_other_buffers({ "force" })
end, { desc = "Close other buffers (force)" })
