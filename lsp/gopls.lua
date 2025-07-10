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
			noSemanticString = true,
			noSemanticNumber = true,
			gofumpt = true,
			usePlaceholders = false,
			staticcheck = true,
			buildFlags = { "-tags", "mage,integration,example,e2e" },
			templateExtensions = { ".gohtml", ".tmpl" },
			vulncheck = "Imports",
			symbolScope = "workspace",
			experimentalPostfixCompletions = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				-- the traditional vet suite
				appends = true,
				asmdecl = true,
				assign = true,
				atomic = true,
				bools = true,
				buildtag = true,
				cgocall = true,
				composite = true,
				copylock = true,
				defers = true,
				deprecated = true,
				directive = true,
				errorsas = true,
				framepointer = true,
				httpresponse = true,
				ifaceassert = true,
				loopclosure = true,
				lostcancel = true,
				nilfunc = true,
				printf = true,
				shift = true,
				sigchanyzer = true,
				slog = true,
				stdmethods = true,
				stdversion = true,
				stringintconv = true,
				structtag = true,
				testinggoroutine = true,
				tests = true,
				timeformat = true,
				unmarshal = true,
				unreachable = true,
				unsafeptr = true,
				unusedresult = true,
				yield = true,

				-- not suitable for vet:
				-- - some (nilness) use go/ssa; see #59714.
				-- - others don't meet the "frequency" criterion;
				--   see GOROOT/src/cmd/vet/README.
				atomicalign = true,
				deepequalerrors = true,
				nilness = true,
				sortslice = true,
				embeddirective = true,

				shadow = true,
				useany = true,

				-- "simplifiers": analyzers that offer mere style fixes
				-- gofmt -s suite:
				simplifycompositelit = true,
				simplifyrange = true,
				simplifyslice = true,
				-- other simplifiers:
				infertypeargs = true,
				unusedparams = true,
				unusedwrite = true,

				-- type-error analyzers
				-- These analyzers enrich go/types errors with suggested fixes.
				fillreturns = true,
				nonewvars = true,
				noresultvalues = true,
				stubmethods = true,
				undeclaredname = true,
				unusedvariable = true,
			},
		},
	},
}
