---@type editor.Language
return {
	treesitter = { "typescript" },
	patterns = { "*.ts", "*.tsx" },
	lsps = {
		{ name = "vtsls" }
	},
	pkgs = { "vtsls" }
}
