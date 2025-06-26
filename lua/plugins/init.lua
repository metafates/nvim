-- Bootstrap lazy.nvim
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "/lazy/lazy.nvim")

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"

	local cmd = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	local out = cmd:wait()

	if out.code ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})

		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins/specs" },
	},
	install = { colorscheme = { vim.cmd.colorscheme() } },
	checker = { enabled = true },
	performance = {
		rtp = { disabled_plugins = { "netrwPlugin", "tohtml", "matchit" } },
	},
})
