local root_markers = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
	".git",
}

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = root_markers,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "strict",
				autoImportCompletions = true,
			},
		},
	},
}
