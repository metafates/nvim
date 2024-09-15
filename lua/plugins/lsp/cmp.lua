return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	commit = "ae644feb7b67bf1ce4260c231d1d4300b19c6f30",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			commit = "e808bee352d1a6fcf902ca1a71cee76e60e24071",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end

				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					commit = "00ebcaa159e817150bd83bfe2d51fa3b3377d5c4",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		{
			"saadparwaiz1/cmp_luasnip",
			commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
		},
		{
			"hrsh7th/cmp-nvim-lsp",
			commit = "39e2eda76828d88b773cc27a3f61d2ad782c922d",
		},
		{
			"hrsh7th/cmp-path",
			commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
		},
		{
			"hrsh7th/cmp-buffer",
			commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			---@diagnostic disable-next-line: missing-fields
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(_, item)
					local icon, hl = require("mini.icons").get("lsp", item.kind)

					item.menu = item.kind
					item.kind = " " .. icon .. " "
					item.kind_hl_group = hl

					return item
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				["<Tab>"] = cmp.mapping.confirm({ select = true }),

				["<C-Space>"] = cmp.mapping.complete({}),

				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{
					name = "lazydev",
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{
					name = "buffer",
					option = {
						get_bufnrs = function()
							-- visible buffers less than 1 MB
							local size_limit = 1024 * 1024
							local bufs = {}

							for _, win in ipairs(vim.api.nvim_list_wins()) do
								local buf = vim.api.nvim_win_get_buf(win)

								local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
								if byte_size <= size_limit then
									bufs[buf] = true
								end
							end

							return vim.tbl_keys(bufs)
						end,
					},
				},
			},
		})
	end,
}
