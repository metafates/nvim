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
			move_down = "<C-J>",
			move_up = "<C-K>",
		},
	})

	vim.ui.select = MiniPick.ui_select
end

local function setup_files()
	require("mini.files").setup()

	vim.keymap.set("n", "<leader>fe", function()
		if not MiniFiles.close() then
			MiniFiles.open()
		end
	end)
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
	require("mini.starter").setup()
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
	require("mini.diff").setup()
end

return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		setup_misc()
		setup_pick()
		setup_files()
		setup_pairs()
		setup_tabline()
		setup_starter()
		setup_sessions()
		setup_extra()
		setup_notify()
		setup_extra()
		setup_bufremove()
		setup_indentscope()
		setup_statusline()
		setup_git()
		setup_diff()
	end,
}
