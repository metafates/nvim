local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth",
	require("plugins.bufferline"),
	require("plugins.hop"),
	require("plugins.toggleterm"),
	require("plugins.gitsigns"),
	require("plugins.project"),
	require("plugins.which-key"),
	require("plugins.telescope"),
	require("plugins.lspconfig"),
	require("plugins.conform"),
	require("plugins.cmp"),
	require("plugins.theme"),
	require("plugins.todo-comments"),
	require("plugins.mini"),
	require("plugins.treesitter"),
	require("plugins.neotest"),
	require("plugins.treesitter-context"),
	require("plugins.neo-tree"),
	require("plugins.lint"),
	require("plugins.indent-line"),
	require("plugins.autopairs"),
	require("plugins.code-runner"),
	require("plugins.barbecue"),
})
