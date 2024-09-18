vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_option_key_is_meta = "both"
vim.g.neovide_cursor_smooth_blink = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,i-ci-ve-r-cr-o:blinkwait700-blinkoff400-blinkon175"
vim.g.neovide_refresh_rate = 160

local font = {
	name = "JetBrainsMono Nerd Font Mono",
	size = 16,
}

function font:sync()
	vim.opt.guifont = { self.name, string.format(":h%d", self.current_size or self.size) }
end

function font:add_size(delta)
	self.current_size = (self.current_size or self.size) + delta

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
	font:add_size(2)
end)
map(all_modes, "<D-->", function()
	font:add_size(-2)
end)
map(all_modes, "<D-0>", function()
	font:reset_size()
end)

map(all_modes, "<D-v>", require("utils.clipboard").paste, { noremap = true, silent = true })

map(all_modes, "<D-}>", vim.cmd.bnext)

map(all_modes, "<D-{>", vim.cmd.bprevious)

map(all_modes, "<D-w>", vim.cmd.bd)
