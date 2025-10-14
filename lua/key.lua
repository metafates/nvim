local set = require("util.keymap").set

vim.g.mapleader = " "

set("n", ";", ":")

set("n", "f", function()
	MiniJump2d.start(MiniJump2d.builtin_opts.word_start)
end)

-- switch windows
for _, key in ipairs({ "h", "j", "k", "l" }) do
	set("n", "<c-" .. key .. ">", "<c-w>" .. key)
end

set({ "n", "x" }, "0", "^", { noremap = true })

set("n", "<esc>", vim.cmd.nohlsearch)

set("i", "jk", "<esc>")
set("n", ",w", vim.cmd.write, { silent = true })
set("n", ",a", vim.cmd.wall, { silent = true })
set("n", ",q", vim.cmd.q)
set("n", "<leader>qq", vim.cmd.qa, "exit")
set("n", "<leader>qQ", "<cmd>qa!<cr>", "exit")

set("n", "L", vim.cmd.bnext, { silent = true })
set("n", "H", vim.cmd.bprevious, { silent = true })
set("n", "<leader>bd", vim.cmd.bd, "buffer delete")

set("n", "<leader>bD", function()
	vim.cmd([[bd!]])
end, "buffer delete (force)")

set("n", "<leader>sk", function()
	MiniExtra.pickers.keymaps()
end, "picker keymaps")

set("n", "<leader>bz", function()
	MiniMisc.zoom()
end, "zoom")

set("n", "<leader>bo", function()
	local current_buf = vim.fn.bufnr()
	local current_win = vim.fn.win_getid()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })

	for _, buf in ipairs(bufs) do
		if buf.bufnr ~= current_buf then
			pcall(MiniBufremove.delete, buf.bufnr)
		end
	end

	vim.fn.win_gotoid(current_win)
end, "buffers close other")

-- remove conflicting builtin keymaps
for _, lhs in pairs({ "gra", "gri", "grn", "grr" }) do
	pcall(vim.keymap.del, "n", lhs)
end

set("n", "<leader>ca", vim.lsp.buf.code_action, "code action")

set("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "inlay hint toggle")

set("n", "<leader>ur", function()
	vim.cmd([[set rnu!]])
end, "toggle relative line numbers")
set("n", "<leader>ul", function()
	vim.cmd([[set nu!]])
end, "toggle line numbers")

set("n", "<leader>us", function()
	vim.cmd([[set spell!]])
end, "toggle spell")

set("n", { "<leader>uz", "<D-z>" }, require("util.zen").toggle, "toggle zen mode")

set("n", "<leader>un", function()
	MiniNotify.clear()
end, "hide notifications")

set("n", "<leader>uw", function()
	vim.cmd([[set wrap!]])
end, "toggle wrap")

set("n", "<leader>ub", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end, "toggle background")

set("n", "<leader>uc", function()
	vim.cmd([[set cursorline!]])
end, "toggle cursorline")

set("n", "<leader>cc", function()
	local file_path = vim.api.nvim_buf_get_name(0)
	local dir_path = vim.fs.dirname(file_path)

	local items = {
		{ text = "file path", value = file_path },
		{ text = "directory path", value = dir_path },
		{ text = "cwd path", value = vim.fn.getcwd() },
		{ text = "buffer lines", value = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n") },
	}

	local diagnostic = require("util.diagnostic").get_under_cursor()

	if diagnostic then
		table.insert(items, { text = "copy diagnostic under cursor", value = diagnostic })
	end

	MiniPick.start({
		source = {
			name = "Copy to clipboard",
			items = items,
			preview = function(buf_id, item)
				local lines = vim.split(item.value, "\n")
				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
			end,
			choose = function(item)
				vim.fn.setreg("+", item.value)

				vim.notify(string.format("copied %s to clipboard", item.text))
			end,
		},
	})
end, "copy")

for lhs, scope in pairs({
	["gd"] = "definition",
	["gD"] = "declaration",
	["gi"] = "implementation",
	["gr"] = "references",
	["gy"] = "type_definition",
	["<leader>fs"] = "document_symbol",
	["<leader>fS"] = "workspace_symbol",
}) do
	set("n", lhs, function()
		MiniExtra.pickers.lsp({ scope = scope })
	end, "picker lsp " .. scope)
end

set("n", "<leader>cr", vim.lsp.buf.rename, "lsp rename")

set("n", "<leader>ud", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "diagnostic toggle")

set("n", "<leader>sd", function()
	MiniExtra.pickers.diagnostic()
end, "picker diagnostic")

set("n", "<leader>st", function()
	require("util.theme").picker()
end)

set("n", "<leader>d", vim.diagnostic.open_float, "diagnostic open float")

set("n", "<leader>fF", function()
	local path = vim.api.nvim_buf_get_name(0)
	local cwd = vim.fs.dirname(path)

	MiniPick.builtin.files(nil, {
		source = { cwd = cwd },
	})
end, "picker files (buffer cwd)")

set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end, "picker files")
set("n", "<leader>fb", function()
	MiniPick.builtin.buffers()
end, "picker buffers")
set("n", "<leader>sg", function()
	MiniPick.builtin.grep_live()
end, "picker grep live")
set("n", "<leader>sk", function()
	MiniExtra.pickers.keymaps()
end, "picker keymap")
set("n", "<leader>sn", function()
	MiniNotify.show_history()
end, "show notify history")

set("n", "<leader>fe", function()
	if not MiniFiles.close() then
		if vim.bo.filetype == "ministarter" then
			MiniFiles.open(nil, false)
		else
			local path = vim.api.nvim_buf_get_name(0)
			MiniFiles.open(path, false)
		end
	end
end, "files toggle")

set({ "n", "x", "v" }, "<leader>y", [["+y]], "yank selection to system clipboard")

-- comments
set("n", "<c-c>", "gcc<down>", { remap = true, desc = "comment line" })
set("v", "<c-c>", "gc", { remap = true, desc = "comment line" })

set("n", "<leader>uD", function()
	local config = assert(vim.diagnostic.config())

	vim.diagnostic.config({
		virtual_text = not config.virtual_text,
		virtual_lines = not config.virtual_lines,
	})
end, "change diagnostic view")

set("n", "U", vim.cmd.redo, { silent = true })

set("n", "F", "za", "toggle fold")

set("n", "<leader>qs", function()
	MiniSessions.select("read")
end, "session picker")

set("n", "<leader>qd", function()
	MiniSessions.select("delete")
end, "session delete")

set("n", "<leader>qw", function()
	vim.ui.input({ prompt = "Enter session name: " }, function(input)
		if not input then
			return
		end

		MiniSessions.write(input)
	end)
end, "session write")

set({ "n", "v" }, "<leader>g", function()
	MiniGit.show_at_cursor()
end)

set({ "n", "v" }, "gh", "^")
set({ "n", "v" }, "gl", "$")
