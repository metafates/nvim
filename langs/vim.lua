---@type editor.Language
return {
	treesitter = { "vim" },
	patterns = { "*.vim", "*.lua" },
	lsps = { { name = "vimls" } },
	pkgs = { "vim-language-server" }
}
