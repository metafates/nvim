local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local plugins = {
	require("plugins.mini"),
	require("plugins.treesitter"),
	require("plugins.lsp"),
	require("plugins.autoformat"),
	require("plugins.autopairs"),
	require("plugins.theme"),
}

vim.list_extend(plugins, require("plugins.extra"))

require("lazy").setup(plugins, {
	rocks = {
		enabled = false,
		install = {
			colorscheme = { "tokyonight", "habamax" },
		},
	},
	profiling = {
		loader = true,
		require = true,
	},
})
