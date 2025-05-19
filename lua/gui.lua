vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_option_key_is_meta = "both"
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_refresh_rate = 160
-- vim.g.neovide_opacity = 0.9
-- vim.g.transparency = 0.9
-- vim.g.neovide_window_blurred = true

vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,i-ci-ve-r-cr-o:blinkwait700-blinkoff400-blinkon175"

local ALL_MODES = { "n", "v", "s", "x", "o", "i", "l", "c", "t" }

local set = require("util.keymap").set

set(ALL_MODES, "<D-v>", function()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end, { noremap = true, silent = true })

set(ALL_MODES, "<D-}>", vim.cmd.bnext)

set(ALL_MODES, "<D-{>", vim.cmd.bprevious)

set(ALL_MODES, "<D-w>", vim.cmd.bd)

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

set(ALL_MODES, "<D-=>", function()
	change_scale_factor(1.25)
end)

set(ALL_MODES, "<D-->", function()
	change_scale_factor(1 / 1.25)
end)

set(ALL_MODES, "<D-0>", function()
	vim.g.neovide_scale_factor = 1.0
end)
