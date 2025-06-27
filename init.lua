vim.loader.enable(true)

require("key")
require("opt")
require("auto")
require("lsp")
require("cmd")

if vim.g.neovide then
	require("gui")
end

require("plugins")

require("util.theme").load()
