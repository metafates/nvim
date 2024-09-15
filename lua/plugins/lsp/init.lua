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
	commit = "0d027de8820917db548486564d0d5b17af4b3db4",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "Mason",
	dependencies = {
		{
			"williamboman/mason.nvim",
			config = true,
			commit = "e2f7f9044ec30067bc11800a9e266664b88cda22",
		},
		{
			"williamboman/mason-lspconfig.nvim",
			commit = "25c11854aa25558ee6c03432edfa0df0217324be",
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			commit = "c5e07b8ff54187716334d585db34282e46fa2932",
		},
		{
			"folke/lazydev.nvim",
			commit = "491452cf1ca6f029e90ad0d0368848fac717c6d2",
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
			commit = "ce76f6f6cdc9201523a5875a4471dcfe0186eb60",
		},
		require("plugins.lsp.cmp"),
	},
	config = function()
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, other_tools)

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

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
