local function setup_clue()
	local clue = require("mini.clue")

	local triggers = {
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
	}

	clue.setup({
		window = {
			delay = 0,
			config = {
				width = "auto",
			},
		},
		triggers = triggers,

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

	-- icons.tweak_lsp_kind()
end

local function setup_basics()
	require("mini.basics").setup({
		options = {
			extra_ui = true, -- depends on my mood =)
		},
	})
end

local function setup_pick()
	local pick = require("mini.pick")

	-- local win_config_center = function()
	-- 	local height = math.floor(0.618 * vim.o.lines)
	-- 	local width = math.floor(0.618 * vim.o.columns)
	--
	-- 	return {
	-- 		anchor = "NW",
	-- 		height = height,
	-- 		width = width,
	-- 		row = math.floor(0.5 * (vim.o.lines - height)),
	-- 		col = math.floor(0.5 * (vim.o.columns - width)),
	-- 	}
	-- end

	local win_config_bottom = function()
		local height = math.floor(0.3 * vim.o.lines)
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
			config = win_config_bottom,
		},
	})

	vim.ui.select = pick.ui_select
end

local function setup_cursorword()
	require("mini.cursorword").setup({
		delay = 50,
	})
end

local function setup_extra()
	require("mini.extra").setup()
end

local function setup_files()
	require("mini.files").setup({
		options = {
			use_as_default_explorer = true,
		},
		windows = {
			preview = true,
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

			-- Highlight hex color strings (`#FFFFFF`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
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

local function setup_starter()
	local starter = require("mini.starter")

	starter.setup({
		silent = true,
		header = "",
		footer = function()
			local stats = require("lazy").stats()

			return string.format("Loaded %d/%d plugins in %d ms", stats.loaded, stats.count, stats.startuptime)
		end,
		evaluate_single = true,
		items = {
			starter.sections.builtin_actions(),
			require("utils.sessions").starter_section,
			starter.sections.recent_files(5, false),
			starter.sections.recent_files(5, true),
		},
		content_hooks = {
			starter.gen_hook.adding_bullet(),
			starter.gen_hook.indexing("all", { "Builtin actions", "Sessions" }),
			starter.gen_hook.padding(3, 2),
		},
	})
end

local function setup_statusline()
	require("mini.statusline").setup()
end

local function setup_tabline()
	local tabline = require("mini.tabline")

	---@param buf_id number
	---@param label string
	---@return string
	local function format(buf_id, label)
		local suffix = vim.bo[buf_id].modified and "+ " or ""

		local listed = require("utils.buffers").list()
		local idx = listed:enumerate():find(function(_, item)
			return item == buf_id
		end)

		return " " .. idx .. tabline.default_format(buf_id, label) .. suffix
	end

	tabline.setup({
		format = format,
		tabpage_section = "right",
	})
end

local function setup_sessions()
	require("mini.sessions").setup({
		autoread = true,
		autowrite = true,
		directory = require("utils.sessions").dir(),
	})
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
	local ai = require("mini.ai")
	local treesitter = ai.gen_spec.treesitter

	ai.setup({
		custom_textobjects = {
			F = treesitter({ a = "@function.outer", i = "@function.inner" }),
			o = treesitter({
				a = { "@conditional.outer", "@loop.outer" },
				i = { "@conditional.inner", "@loop.inner" },
			}),
		},
	})
end

return {
	"echasnovski/mini.nvim",
	dependencies = {
		-- for mini.ai
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		setup_icons()
		setup_basics()
		-- setup_pick()
		setup_cursorword()
		setup_extra()
		setup_files()
		setup_jump2d()
		setup_indentscope()
		setup_diff()
		setup_hipatterns()
		setup_notify()
		setup_git()
		setup_surround()
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
