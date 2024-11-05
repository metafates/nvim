local M = {}

--- Pluralize the given word by selecting singular or plural form based on the count
---@param count integer
---@param singular string
---@param plural string? plural form. default is singular + 's'
---@return string
function M.pluralize(count, singular, plural)
	plural = plural or singular .. "s"

	if count == 1 then
		return string.format("%d %s", count, singular)
	end

	return string.format("%d %s", count, plural)
end

return M
