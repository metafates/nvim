local section = require("util").section

section("packages", function ()
	vim.pack.add({
		'https://github.com/nvim-mini/mini.nvim',
		'https://github.com/neovim/nvim-lspconfig',
		'https://github.com/mason-org/mason.nvim',
		'https://github.com/nvim-treesitter/nvim-treesitter'
	})
end)

section("theme", function ()
	vim.cmd.colorscheme("retrobox")
end)

section("mini", function ()
	require("mini.pick").setup({})
	require("mini.cmdline").setup({})
	require("mini.tabline").setup({})
	require("mini.files").setup({})
	require("mini.pairs").setup({})
	require("mini.notify").setup({})
	require("mini.icons").setup({})
	require("mini.snippets").setup({})
	require("mini.completion").setup({})
	require("mini.basics").setup({
		options = {
			extra_ui = true
		},
		mappings = {
			windows = true
		}
	})
end)

section("keys", function ()
	vim.g.mapleader = " "

	vim.keymap.set("i", "jk", "<esc>")
	vim.keymap.set("n", ";", ":", { noremap = true })
	vim.keymap.set("n", "L", vim.cmd.bnext, { silent = true })
	vim.keymap.set("n", "H", vim.cmd.bprevious, { silent = true })
	vim.keymap.set("n", "<leader>f", require("mini.pick").builtin.files)
	vim.keymap.set("n", ",w", vim.cmd.write)
	vim.keymap.set("n", ",q", vim.cmd.quit)

	section("lsp", function ()
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
	end)

	vim.keymap.set("n", "f", function ()
		local files = require("mini.files")

		if not files.close() then files.open() end
	end)

	section("popup menu", function ()
		for lhs, rhs in pairs({
			["<tab>"] = "<c-y>",
			["<c-j>"] = "<c-n>",
			["<c-k>"] = "<c-p>"
		}) do
			vim.keymap.set("i", lhs, function ()
				if vim.fn.pumvisible() ~= 0 then
					return rhs
				end

				return lhs
			end, { expr = true }
			)
		end
	end)
end)

section("options", function ()
	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.scrolloff = 5
	vim.opt.hlsearch = true
	vim.opt.breakindent = true

	vim.opt.autoread = true
	vim.opt.swapfile = false
	vim.opt.undofile = true
	vim.opt.backup = false
	vim.opt.writebackup = false

	vim.opt.completeopt:append({ "fuzzy", "menuone", "preview", "noinsert" })
end)

section("languages", function ()
	local language = require("language")

	local names = {}
	local patterns = {}
	local packages = {}
	local lsps = {}

	for _, lang in ipairs({
		language.Lua,
		language.Go,
		language.Markdown,
		language.Bash,
		language.JSON
	}) do
		table.insert(names, lang.name)

		for _, lsp in ipairs(lang.lsps) do
			table.insert(lsps, lsp)
		end

		for _, pattern in ipairs(lang.patterns) do
			table.insert(patterns, pattern)
		end

		for _, pkg in ipairs(lang.pkgs) do
			table.insert(packages, pkg)
		end
	end

	section("treesitter", function ()
		require('nvim-treesitter').install(names)

		vim.api.nvim_create_autocmd('FileType', {
			pattern = names,
			callback = function ()
				vim.treesitter.start()
			end
		})
	end)

	section("lsp", function ()
		require("mason").setup()

		local reg = require("mason-registry")

		for _, name in ipairs(packages) do
			local pkg = reg.get_package(name)

			if not pkg:is_installed() then
				vim.notify("installing " .. name, vim.log.levels.INFO)

				pkg:install()
			end
		end

		vim.lsp.enable(lsps)
	end)

	section("formatters", function ()
		vim.api.nvim_create_autocmd('BufWritePre', {
			pattern = patterns,
			callback = function ()
				vim.lsp.buf.format()
			end
		})
	end)

	section("diagnostics", function ()
		vim.diagnostic.config({
			virtual_text = true,
			update_in_insert = false
		})
	end)
end)
