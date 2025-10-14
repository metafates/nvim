local function setup_misc()
	require("mini.misc").setup()

	MiniMisc.setup_auto_root()
	MiniMisc.setup_termbg_sync()
	MiniMisc.setup_restore_cursor()
end

local function setup_pick()
	local pick = require("mini.pick")

	pick.setup({
		source = { show = pick.default_show },
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
		windows = { preview = true },
		content = { prefix = function() end },
	})
end

local function setup_pairs()
	require("mini.pairs").setup({
		mappings = {
			[" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" },
		},
	})
end

local function setup_tabline()
	require("mini.tabline").setup({
		format = function(buf_id, label)
			local suffix = vim.bo[buf_id].modified and "+ " or ""
			return MiniTabline.default_format(buf_id, label) .. suffix
		end,
	})
end

local function setup_starter()
	require("mini.starter").setup({
		evaluate_single = true,
		footer = "",
		header = "",
	})
end

local function setup_sessions()
	require("mini.sessions").setup()
end

local function setup_notify()
	require("mini.notify").setup()

	vim.notify = MiniNotify.make_notify()
end

local function setup_extra()
	require("mini.extra").setup()
end

local function setup_bufremove()
	require("mini.bufremove").setup()
end

local function setup_indentscope()
	local indent = require("mini.indentscope")

	indent.setup({
		symbol = "▏",
		options = {
			try_as_border = true,
		},
		draw = {
			delay = 0,
			animation = indent.gen_animation.none(),
		},
	})
end

local function setup_statusline()
	require("mini.statusline").setup({
		content = {
			active = function()
				local st = MiniStatusline

				local mode, mode_hl = st.section_mode({ trunc_width = 120 })
				local git = st.section_git({ trunc_width = 40 })
				local filename = st.section_filename({ trunc_width = 140 })
				local fileinfo = st.section_fileinfo({ trunc_width = 120 })
				local location = st.section_location({ trunc_width = 75 })
				local search = st.section_searchcount({ trunc_width = 75 })

				return st.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git } },
					"%<", -- Mark general truncate point
					{ hl = "MiniStatuslineFilename", strings = { filename } },
					"%=", -- End left alignment
					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
					{ hl = mode_hl, strings = { search, location } },
				})
			end,
		},

		use_icons = false,
	})
end

local function setup_git()
	require("mini.git").setup()
end

local function setup_diff()
	require("mini.diff").setup({
		mappings = {
			apply = "",
			textobject = "",
		},
	})
end

local function setup_trailspace()
	require("mini.trailspace").setup()
end

local function setup_surround()
	require("mini.surround").setup()
end

local function setup_clue()
	local clue = require("mini.clue")

	clue.setup({
		window = {
			delay = 0,
			config = { width = "auto" },
		},

		triggers = {
			{ mode = "n", keys = "<leader>" },
			{ mode = "v", keys = "<leader>" },
			{ mode = "x", keys = "<leader>" },
			{ mode = "n", keys = "<c-w>" },
		},

		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.windows(),
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

local function setup_icons()
	require("mini.icons").setup({
		style = "ascii",
	})
end

MiniDeps.add("nvim-mini/mini.nvim")

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
setup_cursorword()
setup_jump2d()
setup_surround()
-- setup_icons()
