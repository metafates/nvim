-- Most of the options is handled by `mini.basics`

vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.breakindent = true
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.inccommand = "split"
vim.opt.scrolloff = 5
vim.opt.hlsearch = true

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·" }

-- disable swap files and enable sync between multiple neovim instances
vim.opt.autoread = true
vim.opt.swapfile = false

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.fillchars = { fold = " " }
vim.opt.foldtext = [[luaeval('require("utils.fold").text')()]]

-- TODO: available on nighlty
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
