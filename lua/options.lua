vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars = { tab = "| ", trail = "·" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Highlight line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
