local map = vim.keymap.set

local function next_completion(keys, reverse)
	map("i", keys, function()
		return vim.fn.pumvisible() ~= 0 and (reverse and "<C-p>" or "<C-n>") or keys
	end, { expr = true })
end

next_completion("<Tab>", false)
next_completion("<C-j>", false)

next_completion("<S-Tab>", true)
next_completion("<C-k>", true)

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("i", "jk", "<Esc>")
map("n", ",w", "<cmd>w<CR>")
map("n", ",q", "<cmd>q<CR>")
map("n", ",Q", "<cmd>q!<CR>")
map("n", ",x", "<cmd>x<CR>")
map("n", ",c", "<cmd>bd<CR>", { silent = true })
map("n", ",C", "<cmd>bd!<CR>", { silent = true })

map("n", "L", "<cmd>bnext<CR>", { silent = true })
map("n", "H", "<cmd>bprevious<CR>", { silent = true })

map("n", "<C-c>", "gcc<DOWN>", { remap = true })
map("v", "<C-c>", "gc", { remap = true })

map("n", "U", "<cmd>redo<CR>", { silent = true })

map({ "n", "x", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to clipboard" })

map("n", "<leader>f", function()
	require("mini.pick").builtin.files()
end, { desc = "Search files" })

map("n", "<leader>F", function()
	local path = vim.api.nvim_buf_get_name(0)

	require("mini.pick").builtin.files(nil, {
		source = { cwd = vim.fs.dirname(path) },
	})
end, { desc = "Search files in current buffer directory" })

map("n", "gr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end)

map("n", "gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end)

map("n", "gD", function()
	require("mini.extra").pickers.lsp({ scope = "type_definition" })
end)

map("n", "gi", function()
	require("mini.extra").pickers.lsp({ scope = "implementation" })
end)

map("n", "<leader>s", function()
	require("mini.extra").pickers.lsp({ scope = "document_symbol" })
end)

map("n", "<leader>S", function()
	require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
end)

map("n", "<leader>/", function()
	require("mini.extra").pickers.buf_lines({ scope = "current" })
end)

map("n", "<leader>g", function()
	require("mini.pick").builtin.grep_live()
end)

map("n", "<leader>m", function()
	require("mini.extra").pickers.git_files({ scope = "modified" })
end)

map("n", "<leader><leader>", function()
	require("mini.pick").builtin.buffers()
end)

map("n", "<leader>d", function()
	require("mini.extra").pickers.diagnostic({ scope = "current" })
end)

map("n", "<leader>D", function()
	require("mini.extra").pickers.diagnostic()
end)

map("n", "T", function()
	local files = require("mini.files")

	if not files.close() then
		files.open(vim.api.nvim_buf_get_name(0))
	end
end)

map("n", "<leader>a", vim.lsp.buf.code_action)
map("n", "<leader>r", vim.lsp.buf.rename)

map("n", "f", function()
	local jump2d = require("mini.jump2d")

	jump2d.start(jump2d.builtin_opts.word_start)
end)

map("n", "<C-f>", function()
	require("mini.diff").toggle_overlay(0)
end)

map("n", "gD", function()
	local line = unpack(vim.api.nvim_win_get_cursor(0))

	require("mini.diff").do_hunks(0, "reset", {
		line_start = line,
		line_end = line,
	})
end)

map({ "n", "x", "v" }, "gG", function()
	require("mini.git").show_at_cursor({
		split = "vertical",
	})
end)

local function close_other_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if current ~= buf then
			vim.api.nvim_buf_delete(buf, opts)
		end
	end

	vim.cmd("redrawtabline")
end

map("n", ",o", function()
	close_other_buffers({})
end)

map("n", ",O", function()
	close_other_buffers({ "force" })
end)

map("n", "<C-r>", function()
	---@diagnostic disable-next-line: undefined-field
	vim.opt.wrap = not vim.opt.wrap._value
end)
