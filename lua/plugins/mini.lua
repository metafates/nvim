local function setup_statusline()
	local statusline = require("mini.statusline")
	-- set use_icons to true if you have a Nerd Font
	statusline.setup({ use_icons = vim.g.have_nerd_font })

	-- You can configure sections in the statusline by overriding their
	-- default behavior. For example, here we set the section for
	-- cursor location to LINE:COLUMN
	---@diagnostic disable-next-line: duplicate-set-field
	statusline.section_location = function()
		return "%2l:%-2v"
	end
end

local function setup_ai()
	-- Better Around/Inside textobjects
	require("mini.ai").setup({ n_lines = 500 })
end

local function setup_starter()
	require("mini.starter").setup({
		header = "Welcome back",
	})
end

return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		setup_starter()
		setup_ai()
		setup_statusline()

		require("mini.cursorword").setup()
	end,
}
