return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod" },
	single_file_support = true,
	settings = {
		gopls = {
			semanticTokens = true,
			-- treesitter will use it's own highlights instead so that printf strings can highlight %s %d ...
			semanticTokenTypes = {
				string = false,
				number = false,
			},
			-- noSemanticString = true,
			-- noSemanticNumber = true,
			gofumpt = true,
			usePlaceholders = false,
			staticcheck = true,
			buildFlags = { "-tags", "mage,integration,example,e2e" },
			templateExtensions = { ".gohtml", ".tmpl" },
			vulncheck = "Imports",
			symbolScope = "workspace",
			diagnosticsDelay = "200ms",
			experimentalPostfixCompletions = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				ignoredError = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
