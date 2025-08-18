local vue_language_server_path = vim.fn.expand("$MASON/packages")
	.. "/vue-language-server"
	.. "/node_modules/@vue/language-server"

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	root_dir = function(bufnr, on_dir)
		-- The project root is where the LSP can be started from
		-- As stated in the documentation above, this LSP supports monorepos and simple projects.
		-- We select then from the project root, which is identified by the presence of a package
		-- manager lock file.
		local project_root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		local project_root = vim.fs.root(bufnr, project_root_markers)
		if not project_root then
			return nil
		end

		-- We know that the buffer is using Typescript if it has a config file
		-- in its directory tree.
		local ts_config_files = { "tsconfig.json", "jsconfig.json" }
		local is_buffer_using_typescript = vim.fs.find(ts_config_files, {
			path = vim.api.nvim_buf_get_name(bufnr),
			type = "file",
			limit = 1,
			upward = true,
			stop = vim.fs.dirname(project_root),
		})[1]
		if not is_buffer_using_typescript then
			return nil
		end

		on_dir(project_root)
	end,
}
