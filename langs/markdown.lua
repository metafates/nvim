---@type editor.Language
return {
	treesitter = { "markdown", "markdown_inline" },
	patterns = { "*.md" },
	lsps = { { name = "marksman" } },
	pkgs = { "marksman" }
}
