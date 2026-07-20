---@type editor.Language
return {
	name = "go",
	patterns = { "*.go" },
	lsps = {
		{
			name = "gopls",
			config = {
				settings = {
					gopls = {
						semanticTokenTypes = {
							string = false,
							number = false
						},
						gofumpt = true,
						staticcheck = true,
						buildFlags = { "-tags", "mage,integration,example,e2e,smoke,functional,e2e_testo" }
					}
				}
			}
		}
	},
	pkgs = { "gopls" },
	on_save = { "source.organizeImports" }
}
