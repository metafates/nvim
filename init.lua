vim.loader.enable()

require("auto")
require("opt")
require("key")
require("lsp")
require("plugins")
require("cmd")

if vim.g.neovide then
	require("gui")
end
