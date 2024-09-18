-- imports order matters

local utils = require("utils.map")

utils.setup_keymap_extender(utils.cyrrilic_extender)

require("globals")
require("options")
require("keymap")
require("autocmd")

if vim.g.neovide then
	require("gui")
end

require("plugins")
