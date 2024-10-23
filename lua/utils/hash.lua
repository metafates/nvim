local M = {}

-- List of adjectives used as slugs.
-- It could be cleaner to store them in a file and read in runtime, but current solution is a bit faster
local adjectives = {
	"calm",
	"gentle",
	"bright",
	"simple",
	"clear",
	"smooth",
	"quiet",
	"steady",
	"fresh",
	"clean",
	"bold",
	"light",
	"subtle",
	"soft",
	"warm",
	"cool",
	"plain",
	"crisp",
	"vivid",
	"natural",
	"easy",
	"neutral",
	"even",
	"bright",
	"polished",
	"mild",
	"tender",
	"rich",
	"balanced",
	"serene",
	"pure",
	"gentle",
	"plain",
	"modern",
	"classic",
	"timeless",
	"focused",
	"detailed",
	"harmonious",
	"simple",
	"organic",
	"smooth",
	"adaptable",
	"versatile",
	"pristine",
	"reliable",
	"consistent",
}

---@param str string
---@return integer
function M.hash(str)
	local hash = 0
	local prime = 31
	local max_integer = 2 ^ 32

	for i = 1, #str do
		local char = str:sub(i, i)
		hash = (hash * prime + string.byte(char)) % max_integer
	end

	return hash
end

function M.slug(s)
	local hash = M.hash(s)

	local index = (hash % #adjectives) + 1

	return adjectives[index]
end

return M
