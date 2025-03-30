-- pum keymaps
-- for lhs, rhs in pairs({
-- 	["<tab>"] = "<c-y>",
-- 	["<c-j>"] = "<c-n>",
-- 	["<c-k>"] = "<c-p>",
-- 	["<cr>"] = "<c-e><cr>",
-- }) do
-- 	vim.keymap.set("i", lhs, function()
-- 		return vim.fn.pumvisible() and rhs or lhs
-- 	end, { expr = true })
-- end

local set = vim.keymap.set

-- switch windows
for _, key in ipairs({ "h", "j", "k", "l" }) do
	set("n", "<c-" .. key .. ">", "<c-w>" .. key)
end

set("n", "<esc>", vim.cmd.nohlsearch)

set("i", "jk", "<esc>")
set("n", ",w", vim.cmd.wa)
set("n", ",q", vim.cmd.q)
set("n", "<leader>qq", vim.cmd.qa)

set("n", "L", vim.cmd.bnext, { silent = true })
set("n", "H", vim.cmd.bprevious, { silent = true })
set("n", "<leader>bd", vim.cmd.bd)
set("n", "<leader>bD", function()
	vim.cmd([[bd!]])
end)
set("n", "<leader>bo", function()
	local current_buf = vim.fn.bufnr()
	local current_win = vim.fn.win_getid()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })

	for _, buf in ipairs(bufs) do
		if buf.bufnr ~= current_buf then
			MiniBufremove.delete(buf.bufnr)
		end
	end

	vim.fn.win_gotoid(current_win)
end)

-- remove conflicting builtin keymaps
for _, lhs in pairs({ "gra", "gri", "grn", "grr" }) do
	pcall(vim.keymap.del, "n", lhs)
end

set("n", "<leader>ca", vim.lsp.buf.code_action)

set("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

for lhs, scope in pairs({
	["gd"] = "definition",
	["gD"] = "declaration",
	["gi"] = "implementation",
	["gr"] = "references",
	["gy"] = "type_definition",
	["<leader>fs"] = "document_symbol",
}) do
	set("n", lhs, function()
		MiniExtra.pickers.lsp({ ["scope"] = scope })
	end)
end

set("n", "<leader>ud", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

set("n", "<leader>sd", function()
	MiniExtra.pickers.diagnostic()
end)

set("n", "<leader>cd", vim.diagnostic.open_float)

set("n", "<leader>sw", function()
	vim.ui.input({ prompt = "Enter session name: " }, function(input)
		MiniSessions.write(input)
	end)
end)

set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end)
set("n", "<leader>fb", function()
	MiniPick.builtin.buffers()
end)
set("n", "<leader>sg", function()
	MiniPick.builtin.grep_live()
end)

set({ "n", "x", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to system clipboard" })

-- comments
set("n", "<c-c>", "gcc<down>", { remap = true })
set("v", "<c-c>", "gc", { remap = true })

set("n", "<leader>uD", function()
	local config = assert(vim.diagnostic.config())

	vim.diagnostic.config({
		virtual_text = not config.virtual_text,
		virtual_lines = not config.virtual_lines,
	})
end)

set("n", "U", vim.cmd.redo, { silent = true })

set("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

set("n", "F", "za")
set("n", "<leader>qs", function() MiniSessions.select("read") end)
