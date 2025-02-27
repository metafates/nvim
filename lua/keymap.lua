local set = require("utils.keymap").set

set({ "n", "x" }, "0", "^", { noremap = true })

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

for i = 1, 9 do
	set("n", "<leader>" .. i, function()
		local buffers = require("utils.buffers").list():totable()

		if i > #buffers then
			return
		end

		vim.cmd.buffer(buffers[i])
	end, "Goto buffer " .. i)
end

set("n", "<leader>" .. 0, function()
	local buffer = require("utils.buffers").list():last()

	vim.cmd.buffer(buffer)
end, "Goto last buffer")

set("n", { "<Tab>", "L" }, vim.cmd.bnext, { silent = true })

set("n", { "<S-Tab>", "H" }, vim.cmd.bprevious, { silent = true })

set("n", "<C-c>", "gcc<DOWN>", { remap = true })

set("v", "<C-c>", "gc", { remap = true })

set("n", "U", vim.cmd.redo, { silent = true })

set({ "n", "x", "v" }, "<leader>y", [["+y]], "Yank selection to clipboard")

set("n", "<leader>f", function()
	require("fzf-lua").files()
end, "Files picker")

set("n", "<leader>F", function()
	local path = vim.api.nvim_buf_get_name(0)
	local cwd = vim.fs.dirname(path)

	require("fzf-lua").files({ cwd = cwd })
end, "Files in current buffer directory picker")

set("n", "<leader>s", function()
	require("fzf-lua").lsp_document_symbols()
end, "Document symbols picker")

set("n", "gr", function()
	require("fzf-lua").lsp_references()
end, "References picker")

set("n", "gd", function()
	require("fzf-lua").lsp_definitions()
end, "Definitions picker")

set("n", "gD", function()
	require("fzf-lua").lsp_typedefs()
end, "Type definitions picker")

set("n", "<leader>w", function()
	require("fzf-lua").lsp_workspace_symbols()
end, "Workspace symbols picker")

set("n", "gi", function()
	require("fzf-lua").lsp_implementations()
end, "Implementations picker")

set("n", "<leader>/", function()
	require("fzf-lua").grep_curbuf()
end, "Live grep (buffer)")

set("n", "<leader>g", function()
	require("fzf-lua").live_grep_native()
end, "Live grep (workspace)")

set("n", "<leader><leader>", function()
	require("fzf-lua").resume()
end, "Resume last picker")

set("n", "<leader>b", function()
	require("fzf-lua").buffers()
end, "Buffers picker")

set("n", "<leader>d", function()
	require("fzf-lua").diagnostics_document()
end, "Diagnostic picker (buffer)")

set("n", "<leader>D", function()
	require("fzf-lua").diagnostics_workspace()
end, "Diagnostic picker (workspace)")

set("n", "T", function()
	local files = require("mini.files")

	if not files.close() then
		files.open(vim.api.nvim_buf_get_name(0))
	end
end)

set("n", "<leader>ca", function()
	require("fzf-lua").lsp_code_actions()
end, "LSP code action")

set("n", "<leader>cl", vim.lsp.codelens.run, "LSP codelens")

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

for _, force in ipairs({ false, true }) do
	local opts = force and { "force" } or {}
	local suffix = force and " (force)" or ""

	set("n", force and ",O" or ",o", function()
		require("utils.buffers").close_other_buffers(opts)
	end, "Close other buffers" .. suffix)

	set("n", force and ",P" or ",p", function()
		require("utils.buffers").close_right_buffers(opts)
	end, "Close right buffers" .. suffix)

	set("n", force and ",I" or ",i", function()
		require("utils.buffers").close_left_buffers(opts)
	end, "Close left buffers" .. suffix)
end

-- https://github.com/chrisgrieser/nvim-spider?tab=readme-ov-file#operator-pending-mode-the-case-of-cw
set("n", "cw", "ce", { remap = true })

set("n", "<leader>cP", function()
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
	---@diagnostic disable-next-line: undefined-field
	vim.opt.bg = vim.opt.bg._value == "dark" and "light" or "dark"
end, "Toggle 'background'")

set("n", "<C-h>", "<C-w>h", "Focus on left window")
set("n", "<C-j>", "<C-w>j", "Focus on below window")
set("n", "<C-k>", "<C-w>k", "Focus on above window")
set("n", "<C-l>", "<C-w>l", "Focus on right window")

set("n", "<leader>Sw", function()
	require("utils.sessions").write()
end, "Write session")

set("n", "<leader>Ss", function()
	require("mini.sessions").select()
end, "Select session")

set("n", "<leader>Sd", function()
	require("mini.sessions").select("delete")
end, "Delete sessions")

set("n", "<leader>Si", function()
	local name = require("utils.sessions").current_name()

	local message = "Not in session"
	if name ~= nil then
		message = name
	end

	require("utils.notify").add(message)
end, "Show session name")

set("n", "<leader>ck", vim.diagnostic.open_float, "Hover diagnostic")

set("n", "F", "za")

-- set("n", "<leader>pf", require("utils.pick").filetype, "Pick filetype")
