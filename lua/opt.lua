vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 5
vim.opt.hlsearch = true
vim.opt.breakindent = true

vim.opt.spell = true
vim.opt.spelllang = "en_us,en-extra,ru"
vim.opt.spelloptions = "camel"

vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.signcolumn = "yes"

vim.opt.completeopt:append({ "fuzzy", "menuone", "preview", "noinsert" })

vim.opt.showmode = false

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- redefined with lsp on attach
vim.opt.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ eob = " ", fold = " " })

vim.cmd.filetype("plugin indent on")

-- vim.opt.winborder = 'shadow'
vim.opt.winborder = "single"

vim.opt.colorcolumn = "80,120"
