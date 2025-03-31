local function setup_misc()
	require("mini.misc").setup()

	MiniMisc.setup_auto_root()
	-- MiniMisc.setup_termbg_sync()
	MiniMisc.setup_restore_cursor()
end

local function setup_pick()
	require("mini.pick").setup({
		options = {
			use_cache = true,
		},
		mappings = {
			move_down = "<c-j>",
			move_up = "<c-k>",
		},
	})

	vim.ui.select = MiniPick.ui_select
end

local function setup_files()
	require("mini.files").setup({
		windows = { preview = true }
	})
end

local function setup_pairs()
	require("mini.pairs").setup({
		mappings = {
			[' '] = { action = 'open', pair = '  ', neigh_pattern = '[%(%[{][%)%]}]' },
		},
	})
end

local function setup_tabline()
	require("mini.tabline").setup({
		format = function(buf_id, label)
			local suffix = vim.bo[buf_id].modified and '+ ' or ''
			return MiniTabline.default_format(buf_id, label) .. suffix
		end
	})
end

local function setup_starter()
	require("mini.starter").setup({
		evaluate_single = true,
	})
end

local function setup_sessions()
	require("mini.sessions").setup()
end

local function setup_notify()
	require("mini.notify").setup({
		lsp_progress = {
			enable = true,
			duration_last = 1000,
		},
	})

	vim.notify = MiniNotify.make_notify()
end

local function setup_extra()
	require("mini.extra").setup()
end

local function setup_bufremove()
	require("mini.bufremove").setup()
end

local function setup_indentscope()
	require("mini.indentscope").setup({
		symbol = "▏"
	})
end

local function setup_statusline()
	require("mini.statusline").setup()
end

local function setup_git()
	require("mini.git").setup()
end

local function setup_diff()
	require("mini.diff").setup({
		view = { style = "sign" }
	})
end

local function setup_trailspace()
	require("mini.trailspace").setup()
end

local function setup_clue()
	local clue = require("mini.clue")

	clue.setup({
		window = {
			delay = 0,
			config = { width = "auto" }
		},

		triggers = {
			{ mode = 'n', keys = '<leader>' },
			{ mode = 'v', keys = '<leader>' },
			{ mode = 'x', keys = '<leader>' },

			{ mode = 'n', keys = '<c-w>' },
		},

		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.windows(),
		},
	})
end

local function setup_hipatterns()
	local hi_words = require('mini.extra').gen_highlighter.words

	require('mini.hipatterns').setup({
		highlighters = {
			todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
		},
	})
end

local function setup_cursorword()
	require("mini.cursorword").setup()
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

return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		setup_extra()
		setup_misc()
		setup_pick()
		setup_files()
		setup_pairs()
		setup_tabline()
		setup_starter()
		setup_sessions()
		setup_extra()
		setup_notify()
		setup_bufremove()
		setup_indentscope()
		setup_statusline()
		setup_git()
		setup_diff()
		setup_trailspace()
		setup_clue()
		setup_hipatterns()
		setup_cursorword()
		setup_jump2d()
	end,
}
