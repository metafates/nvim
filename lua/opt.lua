vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 5
vim.opt.hlsearch = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.completeopt:append({ "fuzzy", "menuone", "preview", "noinsert" })

vim.opt.showmode = false

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- redefined with lsp on attach
vim.opt.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- vim.opt.winborder = 'shadow'
vim.opt.winborder = 'single'

vim.cmd.colorscheme("retrobox")
