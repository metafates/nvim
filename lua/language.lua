---@class editor.LanguageServer
---@field name   string
---@field config vim.lsp.Config?

---@class editor.Language
---@field name     string
---@field patterns string[]
---@field lsps     editor.LanguageServer[]
---@field pkgs     string[]
---@field on_save  string[]?

---@type editor.Language[]
local languages = {}

---@param l editor.Language
---@return editor.Language
local function lang(l)
	table.insert(languages, l)

	return l
end

local M = {}

M.Lua = lang { name = "lua", patterns = { "*.lua" }, lsps = { { name = "emmylua_ls" } }, pkgs = { "emmylua_ls" } }
M.Go = lang {
	name = "go",
	patterns = { "*.go" },
	lsps = {
		{
			name = "gopls",
			config = {
				settings = {
					gopls = {
						semanticTokenTypes = {
							string = false,
							number = false
						},
						gofumpt = true,
						staticcheck = true,
						buildFlags = { "-tags", "mage,integration,example,e2e,smoke,functional,e2e_testo" }
					}
				}
			}
		}
	},
	pkgs = { "gopls" },
	on_save = { "source.organizeImports" }
}
M.Markdown = lang { name = "markdown", patterns = { "*.md" }, lsps = { { name = "marksman" } }, pkgs = { "marksman" } }
M.JSON = lang { name = "json", patterns = { "*.json" }, lsps = { { name = "jsonls" } }, pkgs = { "json-lsp" } }
M.Bash = lang {
	name = "bash",
	patterns = { "*.sh" },
	lsps = { { name = "bashls" } },
	pkgs = { "bash-language-server", "shellcheck" }
}
M.Make = lang { name = "make", patterns = { "Makefile" } }
M.TOML = lang { name = "toml", patterns = { "*.toml" }, lsps = { { name = "tombi" } }, pkgs = { "tombi" } }
M.Vim = lang {
	name = "vim",
	patterns = { "*.vim", "*.lua" },
	lsps = { { name = "vimls" } },
	pkgs = { "vim-language-server" }
}

---@return editor.Language[]
function M.all()
	return languages
end

return M
