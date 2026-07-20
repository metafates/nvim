---@type editor.Language
return {
	treesitter = { "python" },
	patterns = { "*.py" },
	lsps = {
		{ name = "basedpyright" },
		{ name = "ruff" }
	},
	pkgs = { "basedpyright", "ruff" }
}
