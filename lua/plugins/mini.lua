local function setup_clue()
	local clue = require("mini.clue")

	clue.setup({
		window = {
			delay = 0,
			config = {
				width = "auto",
			},
		},
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },

			-- mini.basics toggles
			{ mode = "n", keys = "\\" },

			-- comma binds
			{ mode = "n", keys = "," },

			-- mini bracketed
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },
		},

		clues = {
			-- Enhance this by adding descriptions for <Leader> mapping groups
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
		},
	})
end

local function setup_icons()
	local icons = require("mini.icons")
	icons.setup()

	icons.tweak_lsp_kind()
end

local function setup_basics()
	require("mini.basics").setup({
		options = {
			extra_ui = true,
		},
		mappings = {
			windows = true,
		},
	})
end

local function setup_pick()
	local pick = require("mini.pick")

	local win_config = function()
		local height = math.floor(0.5 * vim.o.lines)
		local width = vim.o.columns

		return {
			anchor = "NW",
			height = height,
			width = width,
			row = vim.o.lines - height,
			col = 0,
		}
	end

	pick.setup({
		mappings = {
			move_down = "<C-j>",
			move_up = "<C-k>",
		},
		options = {
			use_cache = true,
		},
		window = {
			config = win_config,
		},
	})

	vim.ui.select = pick.ui_select
end

local function setup_cursorword()
	require("mini.cursorword").setup()
end

local function setup_extra()
	require("mini.extra").setup()
end

local function setup_files()
	require("mini.files").setup({
		options = {
			use_as_default_explorer = true,
		},
	})
end

local function setup_jump2d()
	require("mini.jump2d").setup({
		view = {
			dim = true,
			n_steps_ahead = 1,
		},
		allowed_lines = {
			blank = false,
		},
		mappings = {
			start_jumping = "",
		},
	})
end

local function setup_indentscope()
	local indentscope = require("mini.indentscope")

	indentscope.setup({
		symbol = "▏",
		draw = {
			delay = 50,
			animation = indentscope.gen_animation.none(),
		},
	})
end

local function setup_diff()
	require("mini.diff").setup({
		view = {
			style = "sign",
			-- signs = { add = "+", change = "~", delete = "-" },
		},
		mappings = {
			apply = "",
			reset = "",
		},
	})
end

local function setup_hipatterns()
	local hipatterns = require("mini.hipatterns")

	hipatterns.setup({
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end

local function setup_completion()
	require("mini.completion").setup({
		delay = { completion = 0 },
		lsp_completion = {
			source_func = "omnifunc",
			auto_setup = false,
		},
	})
end

local function setup_notify()
	local notify = require("mini.notify")

	notify.setup()

	vim.notify = notify.make_notify()
end

local function setup_git()
	require("mini.git").setup()
end

local function setup_surround()
	require("mini.surround").setup()
end

local function setup_pairs()
	require("mini.pairs").setup()
end

local function setup_starter()
	local starter = require("mini.starter")

	starter.setup({
		header = "",
		footer = "",
		evaluate_single = true,
		items = {
			starter.sections.builtin_actions(),
			starter.sections.recent_files(5, false),
			starter.sections.recent_files(5, true),
			starter.sections.sessions(5, true),
		},
		content_hooks = {
			starter.gen_hook.adding_bullet(),
			starter.gen_hook.indexing("all", { "Builtin actions" }),
			starter.gen_hook.padding(3, 2),
		},
	})
end

local function setup_statusline()
	require("mini.statusline").setup()
end

local function setup_tabline()
	require("mini.tabline").setup()
end

local function setup_sessions()
	require("mini.sessions").setup()
end

local function setup_splitjoin()
	require("mini.splitjoin").setup()
end

local function setup_visits()
	require("mini.visits").setup()
end

local function setup_misc()
	local misc = require("mini.misc")

	misc.setup_auto_root()
	misc.setup_termbg_sync()
	misc.setup_restore_cursor()
end

local function setup_bracketed()
	require("mini.bracketed").setup()
end

local function setup_ai()
	require("mini.ai").setup()
end

return {
	"echasnovski/mini.nvim",
	commit = "e50cf9de614500a20e47cfc50e30a100042f91c3",
	config = function()
		setup_icons()
		setup_basics()
		setup_pick()
		setup_cursorword()
		setup_extra()
		setup_files()
		setup_jump2d()
		setup_indentscope()
		setup_diff()
		setup_hipatterns()
		setup_completion()
		setup_notify()
		setup_git()
		setup_surround()
		setup_pairs()
		setup_starter()
		setup_statusline()
		setup_tabline()
		setup_sessions()
		setup_clue()
		setup_splitjoin()
		setup_visits()
		setup_misc()
		setup_bracketed()
		setup_ai()
	end,
}
