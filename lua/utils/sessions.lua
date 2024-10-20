local M = {}

---@return string?
function M.best_candidate()
	local name = M.current_name()

	if name ~= nil and M.exists(name) then
		return name
	end

	return require("mini.sessions").get_latest()
end

function M.starter_section()
	local section_name = "Sessions"

	local items = {}

	local name = M.best_candidate()

	if name ~= nil then
		table.insert(items, {
			name = string.format("Load session %q", name),
			action = function()
				M.read({ force = true })
			end,
			section = section_name,
		})
	end

	table.insert(items, {
		name = "Sessions picker",
		action = function()
			require("mini.sessions").select()
		end,
		section = section_name,
	})

	return items
end

---@return string?
function M.current_name()
	local misc = require("mini.misc")

	---@type string
	local path

	do
		local root = misc.find_root()

		if root == nil then
			root = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
		end

		path = root
	end

	local name = vim.fs.basename(path)

	if name == "" then
		return nil
	end

	local slug = require("utils.hash").slug(path)

	return string.format("%s-%s", slug, name)
end

---@return string
function M.dir()
	local data = vim.fn.stdpath("data")

	if type(data) == "table" then
		data = data[1]
	end

	return vim.fs.joinpath(data, "/session")
end

---@param session string
---@return boolean
function M.exists(session)
	local path = vim.fs.joinpath(M.dir(), session)

	return require("utils.fs").exists(path)
end

---@param opts table?
function M.read(opts)
	require("mini.sessions").read(M.best_candidate(), opts)
end

function M.write()
	require("mini.sessions").write(M.current_name())
end

return M
