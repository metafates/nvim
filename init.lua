local section = require("util").section

vim.pack.add {
	"https://github.com/nvim-mini/mini.nvim", "https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim", "https://github.com/nvim-treesitter/nvim-treesitter"
}

section("theme", function()
	vim.cmd.colorscheme "retrobox"
end)

section(
	"mini",
	function()
		section("pick", function()
			local pick = require("mini.pick")

			pick.setup({
				source = { show = pick.default_show },
				options = {
					use_cache = true
				},
				mappings = {
					move_down = "<c-j>",
					move_up = "<c-k>"
				},
				window = {
					config = function() return { width = vim.o.columns, height = math.max(
						5, math.floor(0.3 * vim.o.lines)
					) } end
				}
			})

			vim.ui.select = pick.ui_select
		end)

		section("misc", function()
			local misc = require("mini.misc")

			misc.setup()

			misc.setup_auto_root()
			misc.setup_termbg_sync()
			misc.setup_restore_cursor()
		end)

		require("mini.cmdline").setup {}
		require("mini.tabline").setup {}
		require("mini.files").setup { windows = { preview = true } }
		require("mini.pairs").setup {}
		require("mini.notify").setup {}
		require("mini.statusline").setup {}
		require("mini.icons").setup {}
		require("mini.git").setup {}
		require("mini.diff").setup {}
		require("mini.bufremove").setup {}
		require("mini.basics").setup {
			options = {
				extra_ui = true
			},
			mappings = {
				windows = true
			}
		}
	end
)

section("keys", function()
	vim.g.mapleader = " "

	local set = vim.keymap.set

	set("i", "jk", "<esc>")
	set("n", ";", ":", { noremap = true })
	set({ "n", "x" }, "0", "^", { noremap = true })
	set({ "n", "x", "v" }, "<leader>y", [["+y]])
	set("n", "U", vim.cmd.redo, { silent = true })

	section("buffers", function()
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

	section("pickers", function()
		section("lsp", function()
			set("n", "R", vim.lsp.buf.rename)
			set("n", "<leader>a", vim.lsp.buf.code_action)

			for key, scope in pairs {
				["gd"] = "definition",
				["<leader>r"] = "references",
				["<leader>D"] = "type_definition",
				["<leader>s"] = "document_symbol",
				["<leader>S"] = "workspace_symbol_live",
				["<leader>i"] = "implementation"
			} do
				set("n", key, function()
					require("mini.extra").pickers.lsp({ scope = scope })
				end)
			end
		end)

		set("n", "<leader>f", require("mini.pick").builtin.files)
		set("n", "<leader>/", require("mini.extra").pickers.buf_lines)
		set("n", "<leader>g", require("mini.pick").builtin.grep_live)
	end)

	set("n", ",w", vim.cmd.write)
	set("n", ",a", vim.cmd.wall)
	set("n", ",q", vim.cmd.quit)

	set("n", "<c-c>", "gcc<down>", { remap = true })
	set("v", "<c-c>", "gc", { remap = true })

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
		set("n", "<leader>d", vim.diagnostic.open_float)
	end)
end)

section("options", function()
	section("ui", function()
		vim.opt.tabstop = 4
		vim.opt.softtabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.scrolloff = 5
		vim.opt.hlsearch = true
		vim.opt.breakindent = true
		vim.opt.background = "dark"
	end)

	section("file", function()
		vim.opt.autoread = true
		vim.opt.swapfile = false
		vim.opt.undofile = true
		vim.opt.backup = false
		vim.opt.writebackup = false
	end)

	section("completion", function()
		vim.opt.completeopt = { "fuzzy", "menu", "menuone", "noinsert", "popup" }
	end)

	section("fold", function()
		vim.opt.foldenable = true
		vim.opt.foldlevel = 99
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- redefined with lsp on attach
		vim.opt.foldtext = ""
		vim.opt.foldcolumn = "0"
		vim.opt.fillchars:append { eob = " ", fold = " " }
	end)
end)

section("languages", function()
	---@type string[]
	local names = {}

	---@type string[]
	local packages = {}

	---@type editor.LanguageServer[]
	local lsps = {}

	for _, lang in pairs(require("language").all()) do
		for _, name in ipairs(lang.treesitter) do
			table.insert(names, name)
		end

		for _, lsp in ipairs(lang.lsps or {}) do
			table.insert(lsps, lsp)
		end

		for _, pkg in ipairs(lang.pkgs or {}) do
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

		vim.lsp.config("*", {
			---@diagnostic disable-next-line: assign-type-mismatch
			capabilities = {
				textDocument = {
					---@diagnostic disable-next-line: missing-fields
					semanticTokens = {
						multilineTokenSupport = true
					}
				}
			}
		})

		for _, lsp in ipairs(lsps) do
			if lsp.config then
				vim.lsp.config(lsp.name, lsp.config)
			end

			vim.lsp.enable(lsp.name)
		end
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
		for name, lang in pairs(require("language").all()) do
			section(name, function()
				vim.api.nvim_create_autocmd("LspAttach", {
					pattern = lang.patterns,
					callback = function(lsp_attach)
						local client = assert(vim.lsp.get_client_by_id(lsp_attach.data.client_id))

						vim.api.nvim_create_autocmd("BufWritePre", {
							pattern = lang.patterns,
							callback = function(buf_write_pre)
								if lang.on_save and #lang.on_save > 0 then
									require("util").exec_code_action(client, lang.on_save)
								end

								if client:supports_method("textDocument/formatting") then
									vim.lsp.buf.format({ bufnr = buf_write_pre.buf, id = client.id })
								end
							end
						})

						if client:supports_method("textDocument/foldingRange") then
							local win = vim.api.nvim_get_current_win()

							vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
						end

						if client:supports_method("textDocument/completion") then
							local chars = {}
							for i = 32, 126 do
								local ch = string.char(i)

								if not string.find(" \"'[](){}", ch, 1, true) then
									table.insert(chars, ch)
								end
							end

							if client.server_capabilities and client.server_capabilities.completionProvider then
								client.server_capabilities.completionProvider.triggerCharacters = chars
							end

							vim.lsp.completion.enable(true, client.id, lsp_attach.buf, { autotrigger = true })

							vim.keymap.set("i", "<c-space>", vim.lsp.completion.get)
						end
					end
				})
			end)
		end
	end)
end)

if vim.g.neovide then
	section("options", function()
		vim.g.neovide_remember_window_size = true
		vim.g.neovide_input_macos_option_key_is_meta = "both"
		vim.g.neovide_cursor_smooth_blink = true
		vim.g.neovide_refresh_rate = 120
		vim.g.neovide_show_border = true
	end)

	section("gui", function()
		local ANY = { "n", "v", "s", "x", "o", "i", "l", "c", "t" }

		section("keys", function()
			vim.keymap.set(ANY, "<D-v>", function()
				local reg = vim.fn.getreg("+") --[[@as string]]

				vim.api.nvim_paste(reg, true, -1)
			end, { noremap = true, silent = true }
			)

			vim.g.neovide_scale_factor = 1.0
			local change_scale_factor = function(delta)
				vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
			end

			vim.keymap.set(ANY, "<D-=>", function()
				change_scale_factor(1.25)
			end)

			vim.keymap.set(ANY, "<D-->", function()
				change_scale_factor(1 / 1.25)
			end)

			vim.keymap.set(ANY, "<D-0>", function()
				vim.g.neovide_scale_factor = 1.0
			end)
		end)
	end)
end
