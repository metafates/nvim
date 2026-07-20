local section = require("util").section

section("packages", function()
	vim.pack.add {
		"https://github.com/nvim-mini/mini.nvim", "https://github.com/neovim/nvim-lspconfig",
		"https://github.com/mason-org/mason.nvim", "https://github.com/nvim-treesitter/nvim-treesitter"
	}
end)

section("theme", function()
	vim.cmd.colorscheme "retrobox"
end)

section("mini", function()
	require("mini.pick").setup {}
	require("mini.cmdline").setup {}
	require("mini.tabline").setup {}
	require("mini.files").setup {}
	require("mini.pairs").setup {}
	require("mini.notify").setup {}
	require("mini.icons").setup {}
	require("mini.bufremove").setup {}
	require("mini.basics").setup {
		options = {
			extra_ui = true
		},
		mappings = {
			windows = true
		}
	}
end)

section("keys", function()
	vim.g.mapleader = " "

	local set = vim.keymap.set

	set("i", "jk", "<esc>")
	set("n", ";", ":", { noremap = true })
	set({ "n", "x" }, "0", "^", { noremap = true })
	set({ "n", "x", "v" }, "<leader>y", [["+y]])

	section("buffer", function()
		set("n", "L", vim.cmd.bnext, { silent = true })
		set("n", "H", vim.cmd.bprevious, { silent = true })
		set("n", "<leader>bd", vim.cmd.bd)
		set("n", "<leader>bo", function()
			local current_buf = vim.fn.bufnr()
			local current_win = vim.fn.win_getid()
			local bufs = vim.fn.getbufinfo { buflisted = 1 }

			for _, buf in ipairs(bufs) do
				if buf.bufnr ~= current_buf then
					pcall(require("mini.bufremove").delete, buf.bufnr)
				end
			end

			vim.fn.win_gotoid(current_win)
		end)
	end)

	set("n", "<leader>f", require("mini.pick").builtin.files)
	set("n", ",w", vim.cmd.write)
	set("n", ",q", vim.cmd.quit)

	section("lsp", function()
		set("n", "gd", vim.lsp.buf.definition)
		set("n", "<leader>r", vim.lsp.buf.rename)
		set("n", "<leader>a", vim.lsp.buf.code_action)
	end)

	set("n", "f", function()
		local files = require("mini.files")

		if not files.close() then files.open() end
	end)

	section("popup menu", function()
		for lhs, rhs in pairs { ["<tab>"] = "<c-y>", ["<c-j>"] = "<c-n>", ["<c-k>"] = "<c-p>" } do
			set("i", lhs, function()
				if vim.fn.pumvisible() ~= 0 then
					return rhs
				end

				return lhs
			end, { expr = true }
			)
		end
	end)

	section("ui", function()
		set("n", "<esc>", vim.cmd.nohlsearch)
		set("n", "<leader>un", require("mini.notify").clear)
		set("n", "<leader>uw", function()
			vim.cmd([[set wrap!]])
		end)
		set("n", "F", "za") -- toggle fold
	end)
end)

section("options", function()
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

	vim.opt.completeopt:append { "fuzzy", "menuone", "preview", "noinsert" }

	vim.opt.foldenable = true
	vim.opt.foldlevel = 99
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- redefined with lsp on attach
	vim.opt.foldtext = ""
	vim.opt.foldcolumn = "0"
	vim.opt.fillchars:append { eob = " ", fold = " " }
end)

section("languages", function()
	local language = require("language")

	local names = {}
	local patterns = {}
	local packages = {}
	local lsps = {}

	for _, lang in ipairs {
		language.Lua, language.Go, language.Markdown, language.Bash, language.JSON, language.TOML, language.Vim
	} do
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

	section("treesitter", function()
		require("nvim-treesitter").install(names)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = names,
			callback = function()
				vim.treesitter.start()
			end
		})
	end)

	section("lsp", function()
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

	section("formatters", function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = patterns,
			callback = function()
				vim.lsp.buf.format()
			end
		})
	end)

	section("diagnostics", function()
		vim.diagnostic.config { virtual_text = true, update_in_insert = false }
	end)
end)

section("autocmds", function()
	section("ui", function()
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				vim.hl.on_yank()
			end
		})
	end)

	section("lsp", function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

				if client:supports_method("textDocument/foldingRange") then
					local win = vim.api.nvim_get_current_win()

					vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
				end

				if client:supports_method("textDocument/completion") then
					-- local chars = {}
					-- for i = 32, 126 do
					-- 	local ch = string.char(i)
					--
					-- 	if not contains({ " ", '"', "'", "[", "]", "(", ")", "{", "}" }, ch) then
					-- 		table.insert(chars, ch)
					-- 	end
					-- end
					-- client.server_capabilities.completionProvider.triggerCharacters = chars

					vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

					vim.keymap.set("i", "<c-space>", vim.lsp.completion.get)
				end
			end
		})
	end)
end)
