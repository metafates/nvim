-- imports order matters

local keymap = require("utils.keymap")

keymap.setup_langmap(keymap.langmap.CYRILLIC)

require("autocmd")
require("globals")
require("options")
require("plugins")
require("keymap")

if vim.g.neovide then
	require("gui")
end
