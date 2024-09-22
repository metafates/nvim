local debug_adapters = { "delve" }

-- these servers will be installed automatically
local servers = {
	gopls = {
		settings = {
			gopls = {
				semanticTokens = true,
				-- treesitter will use it's own highlights instead so that printf strings can highlight %s %d ...
				noSemanticString = true,
				noSemanticNumber = true,
				gofumpt = true,
				usePlaceholders = false,
				staticcheck = true,
				buildFlags = { "-tags", "mage,integration" },
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
	},
	pyright = {},
	rust_analyzer = {},
	jsonls = {},
	bashls = {},
	marksman = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				completion = {
					callSnippet = "Replace",
				},
				hint = {
					enable = true,
					setType = true,
				},
			},
		},
	},
}

local other_tools = {
	"stylua",
	"shfmt",
	"markdownlint",
	"jsonlint",
	"prettierd",
}

return {
	"neovim/nvim-lspconfig",
	pin = true,
	event = { "BufReadPre", "BufNewFile" },
	cmd = "Mason",
	dependencies = {
		{
			"williamboman/mason.nvim",
			config = true,
			pin = true,
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			pin = true,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			pin = true,
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			pin = true,
		},
		{
			"folke/lazydev.nvim",
			pin = true,
			ft = "lua",
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			"Bilal2453/luvit-meta",
			lazy = true,
			pin = true,
		},
		require("plugins.lsp.cmp"),
	},
	config = function()
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, other_tools)

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-nvim-dap").setup({ ensure_installed = debug_adapters })

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					-- https://github.com/neovim/nvim-lspconfig/pull/3232
					if server_name == "tsserver" then
						server_name = "ts_ls"
					end

					local server = servers[server_name] or {}

					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
