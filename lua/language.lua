---@class editor.LanguageServer
---@field name   string
---@field config vim.lsp.Config?

---@class editor.Language
---@field name     string
---@field patterns string[]
---@field lsps     editor.LanguageServer[]?
---@field pkgs     string[]?
---@field on_save  string[]?

---@type editor.Language[]
local languages = {}

local dir = vim.fs.joinpath(vim.fn.stdpath("config"), "langs")

for name, t in vim.fs.dir(dir) do
	path = vim.fs.joinpath(dir, name)

	if t == "file" then
		local ok, res = pcall(dofile, path)

		if ok then
			table.insert(
				languages,
				res --[[@as editor.Language]]
			)
		else
			vim.notify("failed to load " .. path .. ": " .. res, vim.log.levels.ERROR)
		end
	end
end

local M = {}

---@return editor.Language[]
function M.all()
	return languages
end

return M
