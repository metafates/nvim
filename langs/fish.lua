---@type editor.Language
return {
	treesitter = { "fish" },
	patterns = { "*.fish" },
	lsps = {
		{ name = "fish_lsp" }
	},
	pkgs = { "fish-lsp" }
}
