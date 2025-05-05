vim.g.mapleader        = " "
vim.g.maplocalleader   = "\\"

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.scrolloff      = 5
vim.opt.hlsearch       = true
vim.opt.breakindent    = true

vim.opt.spell          = true
vim.opt.spelllang      = "en,ru"
vim.opt.spelloptions   = "camel"

vim.opt.autoread       = true
vim.opt.swapfile       = false
vim.opt.undofile       = true
vim.opt.backup         = false
vim.opt.writebackup    = false

vim.opt.ignorecase     = true -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch      = true -- Show search results while typing
vim.opt.infercase      = true -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase      = true -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent    = true -- Make indenting smart

vim.opt.signcolumn     = 'yes'

vim.opt.completeopt:append({ "fuzzy", "menuone", "preview", "noinsert" })

vim.opt.showmode = false

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- redefined with lsp on attach
vim.opt.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ eob = " ", fold = " " })

vim.cmd.filetype("plugin indent on")

-- vim.opt.winborder = 'shadow'
vim.opt.winborder = 'single'

vim.cmd.colorscheme("retrobox")
