local utils = require("utils")

local font = {
	name = "JetBrainsMono Nerd Font Mono",
	size = 16,
}

function font:sync()
	vim.opt.guifont = { self.name, ":h" .. (self.current_size or self.size) }
end

function font:add_size(delta)
	if self.current_size ~= nil then
		self.current_size = self.current_size + delta
	else
		self.current_size = self.size + delta
	end

	self:sync()
end

function font:reset_size()
	self.current_size = self.size

	self:sync()
end

font:sync()

local all_modes = { "n", "v", "s", "x", "o", "i", "l", "c", "t" }

local map = vim.keymap.set

map(all_modes, "<D-=>", function()
	font:add_size(1)
end)
map(all_modes, "<D-->", function()
	font:add_size(-1)
end)
map(all_modes, "<D-0>", function()
	font:reset_size()
end)

map(all_modes, "<D-v>", utils.paste_from_primary_clipboard, { noremap = true, silent = true })

map(all_modes, "<D-}>", vim.cmd.bnext)

map(all_modes, "<D-{>", vim.cmd.bprevious)

map(all_modes, "<D-w>", vim.cmd.bd)
