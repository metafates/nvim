local M = {}

---@alias langmap table<string, string>

M.langmap = {}

---@type langmap
M.langmap.CYRILLIC = {
	["A"] = "Ф",
	["B"] = "И",
	["C"] = "С",
	["D"] = "В",
	["E"] = "У",
	["F"] = "А",
	["G"] = "П",
	["H"] = "Р",
	["I"] = "Ш",
	["J"] = "О",
	["K"] = "Л",
	["L"] = "Д",
	["M"] = "Ь",
	["N"] = "Т",
	["O"] = "Щ",
	["P"] = "З",
	["Q"] = "Й",
	["R"] = "К",
	["S"] = "Ы",
	["T"] = "Е",
	["U"] = "Г",
	["V"] = "М",
	["W"] = "Ц",
	["X"] = "Ч",
	["Y"] = "Н",
	["Z"] = "Я",

	["a"] = "ф",
	["b"] = "и",
	["c"] = "с",
	["d"] = "в",
	["e"] = "у",
	["f"] = "а",
	["g"] = "п",
	["h"] = "р",
	["i"] = "ш",
	["j"] = "о",
	["k"] = "л",
	["l"] = "д",
	["m"] = "ь",
	["n"] = "т",
	["o"] = "щ",
	["p"] = "з",
	["q"] = "й",
	["r"] = "к",
	["s"] = "ы",
	["t"] = "е",
	["u"] = "г",
	["v"] = "м",
	["w"] = "ц",
	["x"] = "ч",
	["y"] = "н",
	["z"] = "я",

	[","] = "б",
	["."] = "ю",
	[";"] = "ж",
	["{"] = "Х",
	["}"] = "Ъ",
	["["] = "х",
	["]"] = "ъ",
	["\\"] = "ё",
	["@"] = '"',
	["`"] = "]",
	["'"] = "э",
	['"'] = "Э",
	["0"] = "0",
	["1"] = "1",
	["2"] = "2",
	["3"] = "3",
	["4"] = "4",
	["5"] = "5",
	["6"] = "6",
	["7"] = "7",
	["8"] = "8",
	["9"] = "9",
}

local H = {}

---@param langmap langmap
---@return string
function H.generate_vim_langmap(langmap)
	local latin_lower = "abcdefghijklmnopqrstuvwxyz"
	local latin_upper = latin_lower:upper()

	local res = {}

	for c in latin_upper:gmatch(".") do
		table.insert(res, langmap[c])
	end

	table.insert(res, ";" .. latin_upper .. ",")

	for c in latin_lower:gmatch(".") do
		table.insert(res, langmap[c])
	end

	table.insert(res, ";" .. latin_lower)

	return table.concat(res)
end

---@param langmap langmap
---@param keymap string
---@return string
function H.convert_keymap(langmap, keymap)
	local res = ""

	for _, key in ipairs(H.split_keymap(keymap)) do
		if vim.startswith(key, "<") then
			-- Support <C-char> mappings
			local mod, k = key:match([[<(.)%-(.)>]])

			if mod ~= nil and k ~= nil then
				key = string.format("<%s-%s>", mod, langmap[k] or k)
			end

			res = res .. key
		else
			res = res .. (langmap[key] or key)
		end
	end

	return res
end

-- Splits keymap into separate keys
-- For example "<leader>abc" will result {"<leader>", "a", "b", "c"}
---@param keymap string
---@return string[]
function H.split_keymap(keymap)
	---@type string[]
	local res = {}

	local current_special = ""

	for c in keymap:gmatch("%S") do
		if c == "<" then
			current_special = current_special .. c
		elseif c == ">" then
			current_special = current_special .. c

			table.insert(res, current_special)

			current_special = ""
		elseif current_special ~= "" then
			current_special = current_special .. c
		else
			table.insert(res, c)
		end
	end

	return res
end

-- Wrapper for vim.keymap.set with support for lhs array
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts vim.keymap.set.Opts|string ? Served as description if string is passed
function M.set(mode, lhs, rhs, opts)
	if type(opts) == "string" then
		opts = { desc = opts }
	end

	if type(lhs) == "string" then
		vim.keymap.set(mode, lhs, rhs, opts)
		return
	end

	for _, keys in ipairs(lhs) do
		vim.keymap.set(mode, keys, rhs, opts)
	end
end

-- Wraps `vim.api.nvim_set_keymap` so that it will also create an alternative mapping for the specified langmap
---@param langmap langmap
function M.setup_langmap(langmap)
	vim.opt.langmap = H.generate_vim_langmap(langmap)

	local nvim_set_keymap = vim.api.nvim_set_keymap

	---@diagnostic disable-next-line: duplicate-set-field
	vim.api.nvim_set_keymap = function(mode, lhs, rhs, opts)
		nvim_set_keymap(mode, lhs, rhs, opts)
		nvim_set_keymap(mode, H.convert_keymap(langmap, lhs), rhs, opts)
	end

	-- FIXME: Weird behavior for <C-n> <C-p> in completion popup
	-- local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap

	---@diagnostic disable-next-line: duplicate-set-field
	-- vim.api.nvim_buf_set_keymap = function(buffer, mode, lhs, rhs, opts)
	-- 	nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
	-- 	nvim_buf_set_keymap(buffer, mode, convert(lhs), rhs, opts)
	-- end

	-- Some default keys do not work in different layout, idk why
	-- This seems to fix it
	M.set("n", "<C-u>", "<C-u>")
	M.set("n", "<C-d>", "<C-d>")
end

return M
