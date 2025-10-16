MiniDeps.add("Wansmer/symbol-usage.nvim")

local SymbolKind = vim.lsp.protocol.SymbolKind

---@diagnostic disable-next-line: missing-fields
require("symbol-usage").setup({
	kinds = {
		SymbolKind.Function,
		SymbolKind.Method,
		SymbolKind.Interface,
		SymbolKind.Struct,
		SymbolKind.Constant,
		SymbolKind.Field,
		SymbolKind.Class,
	},
	vt_position = "end_of_line",
	implementation = { enabled = true },
})
