local root_markers = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

local library = {
	["${3rd}/luv/library"] = true
}

for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/", true)) do
	library[file] = true
end

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = root_markers,
	log_level = vim.lsp.protocol.MessageType.Warning,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = { globals = { 'vim' } },
			workspace = { library = library },
			telemetry = { enable = false },
		}
	}
}
