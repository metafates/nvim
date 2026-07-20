---@type editor.Language
return {
	treesitter = { "bash" },
	patterns = { "*.sh" },
	lsps = { { name = "bashls" } },
	pkgs = { "bash-language-server", "shellcheck" }
}
