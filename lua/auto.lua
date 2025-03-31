vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.hl.on_yank() end
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		MiniTrailspace.trim_last_lines()
		MiniTrailspace.trim()
	end
})
