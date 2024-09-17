local M = {}

local langmap = {
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

---@param keymap string
---@return string
function M.convert_keymap_to_cyrrilic(keymap)
	local res = ""

	for _, key in ipairs(M.split_keymap(keymap)) do
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
function M.split_keymap(keymap)
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
-- It will also create exact same mappings for cyrillic layout
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts vim.keymap.set.Opts|string ?
function M.map(mode, lhs, rhs, opts)
	---@param keymap string
	---@return string[]
	local function with_cyrillic(keymap)
		return { keymap, M.convert_keymap_to_cyrrilic(keymap) }
	end

	if type(lhs) == "string" then
		lhs = with_cyrillic(lhs)
	else
		lhs = vim.iter(lhs):map(with_cyrillic):flatten():totable()
	end

	M.map_exact(mode, lhs, rhs, opts)
end

-- Wrapper for vim.keymap.set with support for lhs array
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts vim.keymap.set.Opts|string ?
function M.map_exact(mode, lhs, rhs, opts)
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

return M
