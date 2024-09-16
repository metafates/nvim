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

local M = {}

-- Smart backspace as seen in Intellij IDEs
-- https://neovim.discourse.group/t/mapping-for-hungry-backspace/4084
-- Returns appropriate expression to be executed in insert mode
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
