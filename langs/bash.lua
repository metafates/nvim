---@type editor.Language
return {
	name = "bash",
	patterns = { "*.sh" },
	lsps = { { name = "bashls" } },
	pkgs = { "bash-language-server", "shellcheck" }
}
