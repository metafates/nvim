---@type editor.Language
return {
	name = "vim",
	patterns = { "*.vim", "*.lua" },
	lsps = { { name = "vimls" } },
	pkgs = { "vim-language-server" }
}
