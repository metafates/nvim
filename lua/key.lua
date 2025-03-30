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

-- switch windows
for _, key in ipairs({ "h", "j", "k", "l" }) do
	vim.keymap.set("n", "<c-" .. key .. ">", "<c-w>" .. key)
end

vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch)

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", ",w", vim.cmd.wa)
vim.keymap.set("n", ",q", vim.cmd.q)
vim.keymap.set("n", "<leader>qq", vim.cmd.qa)

vim.keymap.set("n", "L", vim.cmd.bnext, { silent = true })
vim.keymap.set("n", "H", vim.cmd.bprevious, { silent = true })
vim.keymap.set("n", "<leader>bd", vim.cmd.bd)
vim.keymap.set("n", "<leader>bD", function()
	vim.cmd([[bd!]])
end)
vim.keymap.set("n", "<leader>bo", function()
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

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<leader>uh", function()
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
	vim.keymap.set("n", lhs, function()
		MiniExtra.pickers.lsp({ ["scope"] = scope })
	end)
end

vim.keymap.set("n", "<leader>ud", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

vim.keymap.set("n", "<leader>sd", function()
	MiniExtra.pickers.diagnostic()
end)

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>sw", function()
	vim.ui.input({ prompt = "Enter session name: " }, function(input)
		MiniSessions.write(input)
	end)
end)

vim.keymap.set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end)
vim.keymap.set("n", "<leader>fb", function()
	MiniPick.builtin.buffers()
end)
vim.keymap.set("n", "<leader>sg", function()
	MiniPick.builtin.grep_live()
end)

vim.keymap.set({ "n", "x", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to system clipboard" })

-- comments
vim.keymap.set("n", "<c-c>", "gcc<down>", { remap = true })
vim.keymap.set("v", "<c-c>", "gc", { remap = true })

vim.keymap.set("n", "<leader>uD", function()
	local config = assert(vim.diagnostic.config())

	vim.diagnostic.config({
		virtual_text = not config.virtual_text,
		virtual_lines = not config.virtual_lines,
	})
end)

vim.keymap.set("n", "U", vim.cmd.redo, { silent = true })

vim.keymap.set("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set("n", "F", "za")
