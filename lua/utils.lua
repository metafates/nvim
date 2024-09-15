local M = {}

---@alias diff_hunk {line_start: integer, line_end: integer}

---@param buf_id integer?
---@return diff_hunk[]
function M.adjacent_diff_hunks(buf_id)
	local diff = require("mini.diff")
	local data = diff.get_buf_data(buf_id or 0)

	if data == nil or #data.hunks == 0 then
		return {}
	end

	---@type diff_hunk?
	local prev_hunk

	---@type diff_hunk[]
	local hunks = {}

	for _, hunk in ipairs(data.hunks) do
		---@type diff_hunk
		local current_hunk

		do
			local line_start = hunk.buf_start
			local line_end = line_start + hunk.buf_count - 1

			current_hunk = { line_start = line_start, line_end = line_end }
		end

		if prev_hunk == nil then
			prev_hunk = current_hunk
		elseif current_hunk.line_start - prev_hunk.line_end == 1 then
			prev_hunk.line_end = current_hunk.line_end
		else
			table.insert(hunks, prev_hunk)

			prev_hunk = current_hunk
		end
	end

	table.insert(hunks, prev_hunk)

	return hunks
end

---@return diff_hunk?
function M.diff_hunk_under_cursor()
	local hunks = M.adjacent_diff_hunks(0)

	local line = unpack(vim.api.nvim_win_get_cursor(0))

	for _, hunk in ipairs(hunks) do
		if hunk.line_start <= line and line <= hunk.line_end then
			return hunk
		end
	end
end

---@param action "apply" | "reset" | "yank"
function M.do_diff_hunk_under_cursor(action)
	local hunk = M.diff_hunk_under_cursor()

	if hunk == nil then
		return
	end

	local diff = require("mini.diff")

	diff.do_hunks(0, action, {
		line_start = hunk.line_start,
		line_end = hunk.line_end,
	})
end

---@param filter fun(buf: integer): boolean
---@param opts vim.api.keyset.buf_delete
function M.close_buffers(filter, opts)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if filter(buf) then
			vim.api.nvim_buf_delete(buf, opts)
		end
	end

	vim.cmd.redrawtabline()
end

---@param opts vim.api.keyset.buf_delete
function M.close_other_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	M.close_buffers(function(buf)
		local is_current = buf == current
		local is_terminal = vim.bo[buf].filetype == "toggleterm"

		return not is_current and not is_terminal
	end, opts)
end

function M.paste_from_primary_clipboard()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end

---@param contents string
---@param notify boolean?
function M.copy_to_primary_clipboard(contents, notify)
	vim.fn.setreg("+", contents)

	if notify then
		local n = require("mini.notify")

		local id = n.add(string.format("Copied %q", contents))

		vim.defer_fn(function()
			n.remove(id)
		end, 1000)
	end
end

---@param action string
function M.apply_code_action(action)
	local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
	params.context = { only = { action } }

	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(0))
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

-- Wrapper for vim.keymap.set with support for lhs array
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts vim.keymap.set.Opts?
function M.map(mode, lhs, rhs, opts)
	if type(lhs) == "string" then
		vim.keymap.set(mode, lhs, rhs, opts)
	else
		for _, keys in ipairs(lhs) do
			vim.keymap.set(mode, keys, rhs, opts)
		end
	end
end

local escape_code = vim.api.nvim_replace_termcodes("<Esc>", false, false, true)
local backspace_code = vim.api.nvim_replace_termcodes("<BS>", false, false, true)

local function viml_backspace()
	--[[
	Long ago, in the shadowed realms of Elderwood, there existed a coven of ancient VimScript mages, shrouded in whispers and cloaked in the twilight of forgotten lore. These enigmatic sorcerers wielded a power that transcended the mundane, their eyes aglow with the flicker of arcane knowledge. It was said that they could read the very fabric of reality, unraveling the secrets woven into the tapestry of existence.

	In the heart of their hidden sanctum, beneath the gnarled roots of the Elderwood, they gathered around a tome bound in dragonhide, its pages inscribed with glyphs that shimmered like starlight. Only those deemed worthy could decipher its cryptic verses, for within lay the keys to realms unseen and truths best left unspoken.

	Yet, as the ages turned and shadows lengthened, the mages faded into legend, their whispers carried away by the winds of time. Now, only echoes remain—fragments of their wisdom lingering in the dreams of those who dare to seek. To read what they once knew is to dance upon the precipice of destiny, where the past entwines with the future, and the very essence of magic awaits the brave-hearted.
	--]]

	vim.cmd([[
        let g:exprvalue =
        \ (&indentexpr isnot '' ? &indentkeys : &cinkeys) =~? '!\^F' &&
        \ &backspace =~? '.*eol\&.*start\&.*indent\&' &&
        \ !search('\S','nbW',line('.')) ? (col('.') != 1 ? "\<C-U>" : "") .
        \ "\<bs>" . (getline(line('.')-1) =~ '\S' ? "" : "\<C-F>") : "\<bs>"
	]])

	return vim.g.exprvalue
end

-- Smart backspace as seen in Intellij IDEs
-- https://neovim.discourse.group/t/mapping-for-hungry-backspace/4084
---@return string
function M.smart_backspace()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	local before_cursor_is_whitespace = vim.api.nvim_get_current_line():sub(0, col):match("^%s*$")

	if not before_cursor_is_whitespace then
		return require("nvim-autopairs").autopairs_bs()
	end

	if line == 1 then
		return viml_backspace()
	end

	local correct_indent = require("nvim-treesitter.indent").get_indent(line)
	local current_indent = vim.fn.indent(line)
	-- local previous_line_is_whitespace = vim.api.nvim_buf_get_lines(0, line - 2, line - 1, false)[1]:match("^%s*$")

	if current_indent == correct_indent then
		return viml_backspace()
	end

	if current_indent > correct_indent then
		return escape_code .. "==0wi"
	end

	return backspace_code
end

return M
