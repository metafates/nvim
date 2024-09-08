local function setup_icons()
	require("mini.icons").setup()
end

local function setup_basics()
	require("mini.basics").setup({
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
	require("mini.indentscope").setup({
		symbol = "▏",
	})
end

local function setup_diff()
	require("mini.diff").setup({
		view = {
			style = "sign",
			signs = { add = "+", change = "~", delete = "-" },
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
		delay = { completion = 30 },
	})
end

local function setup_notify()
	local notify = require("mini.notify")

	notify.setup({
		-- fidget.nvim is used instead
		lsp_progress = {
			enable = false,
		},
	})

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
			-- Use this if you set up 'mini.sessions'
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

return {
	"echasnovski/mini.nvim",
	version = false,
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
	end,
}
