---@type editor.Language
return {
	treesitter = { "yaml" },
	patterns = { "*.yaml", "*.yml" },
	lsps = {
		{ name = "yamlls" }
	},
	pkgs = { "yaml-language-server" }
}
