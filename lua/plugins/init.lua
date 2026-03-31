local plugins_list_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins", "list")

for path in vim.fs.dir(plugins_list_path) do
	dofile(vim.fs.joinpath(plugins_list_path, path))
end
