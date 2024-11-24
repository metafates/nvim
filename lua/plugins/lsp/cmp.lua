return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end

				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
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
			experimental = {
				ghost_text = true,
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
