-- these servers will be installed automatically
local servers = {
	gopls = {
		settings = {
			gopls = {
				semanticTokens = true,
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
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				analyses = {
					unreachable = true,
					unusedparams = true,
					nilness = true,
					shadow = true,
					unusedwrite = true,
					useany = true,
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
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "Mason",
	dependencies = {
		{
			"williamboman/mason.nvim",
			config = true,
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"folke/lazydev.nvim",
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
		},
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"MunifTanjim/nui.nvim",
				"SmiteshP/nvim-navic",
			},
			keys = {
				{ "E", "<cmd>Navbuddy<CR>", silent = true },
			},
			opts = {
				window = {
					size = "80%",
				},
				lsp = { auto_attach = true },
			},
		},
	},
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, other_tools)

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
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
