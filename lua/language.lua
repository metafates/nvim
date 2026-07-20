local language = require("vim.treesitter.language")
---@class editor.LanguageServer
---@field name   string          name of the server matching lspconfig file stem from lua/ directory
---@field config vim.lsp.Config? additional config for the server

---@class editor.Language
---@field treesitter string[]                 treesitter parsers name
---@field patterns   string[]                 file patterns for the language, supports glob
---@field lsps       editor.LanguageServer[]? list of language servers for the language
---@field pkgs       string[]?                packages to install for the language from mason
---@field on_save    string[]?                code actions on save

---@type table<string, editor.Language>
local languages = {}

local dir = vim.fs.joinpath(vim.fn.stdpath("config"), "langs")

for name, t in vim.fs.dir(dir) do
	local path = vim.fs.joinpath(dir, name)

	if t == "file" then
		local ok, res = pcall(dofile, path)

		if ok then
			local stem = vim.fn.fnamemodify(name, ":t:r")

			languages[stem] = res --[[@as editor.Language]]
		else
			vim.notify("failed to load " .. path .. ": " .. res, vim.log.levels.ERROR)
		end
	end
end

local M = {}

---@return table<string, editor.Language>
function M.all()
	return languages
end

return M
