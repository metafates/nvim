-- imports order matters

require("globals")
require("options")
require("keymap")
require("autocmd")

if vim.g.neovide then
	require("custom.gui")
end

require("plugins")
