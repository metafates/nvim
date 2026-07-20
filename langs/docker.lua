---@type editor.Language
return {
	treesitter = { "dockerfile" },
	patterns = { "Dockerfile", "*.Dockerfile", "Dockerfile.*" },
	lsps = {
		{ name = "docker_language_server" }
	},
	pkgs = { "docker-language-server" }
}
