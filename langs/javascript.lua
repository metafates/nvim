---@type editor.Language
return {
	treesitter = { "javascript" },
	patterns = { "*.js", "*.mjs" },
	lsps = {
		{ name = "vtsls" }
	},
	pkgs = { "vtsls" }
}
