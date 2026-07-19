# generate workspace settings, e.g. lsp config for lua for working with neovim
workspace:
	nvim --headless --cmd 'source init.lua' --cmd 'lua print(vim.json.encode(vim.api.nvim_get_runtime_file("lua/", true)))' --cmd "quit" 2>&1 | jq '{workspace: {library: .}}' > .emmyrc.json
