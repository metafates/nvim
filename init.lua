-- imports order matters

local keymap = require("utils.keymap")

keymap.setup_langmap(keymap.langmap.CYRILLIC)

require("globals")
require("options")
require("keymap")
require("autocmd")

if vim.g.neovide then
	require("gui")
end

require("plugins")
