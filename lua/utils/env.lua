local M = {}

local H = {}

---@return string path to .env file
function H.get_dotenv_path()
	local cwd = vim.uv.cwd()

	return vim.fs.joinpath(cwd, ".env")
end

---@param contents string
---@return table<string, string> variables
function H.parse_dotenv(contents)
	local lines = vim.split(contents, "\n", { trimempty = true })

	local variables = {}

	for _, line in ipairs(lines) do
		local pair = H.parse_line(line)

		if pair ~= nil then
			variables[pair.key] = pair.value
		end
	end

	return variables
end

---@param line string
---@return { key: string, value: string }?
function H.parse_line(line)
	line = vim.trim(line)

	-- ignore empty lines and comments
	if line == "" or line:sub(1, 1) == "#" then
		return nil
	end

	-- split the line by the first `=` sign
	local key, value = line:match("([^=]+)=(.*)")

	key = vim.trim(key)
	value = vim.trim(value)

	return { key = key, value = H.normalize_value(value) }
end

-- Unquote the value and handle escape symbols
---@param value string
---@return string
function H.normalize_value(value)
	local double_quote = '"'
	local single_quote = "'"

	for _, quote in ipairs({ double_quote, single_quote }) do
		if value:sub(1, 1) == quote and value:sub(-1, -1) == quote then
			-- unquote
			value = value:sub(2, -2)

			-- handle escaped quotes
			value = value:gsub("\\" .. quote, quote)
		end
	end

	return value
end

-- Will try to locate and read .env file in the CWD.
-- Any errors will be ignored
function M.try_load_dotenv()
	local path = H.get_dotenv_path()

	local callback = {
		success = function(data)
			local variables = H.parse_dotenv(data)

			vim.schedule(function()
				for key, value in pairs(variables) do
					vim.env[key] = value
				end

				require("utils.notify").add(string.format("Loaded %q", path), { duration = 2000 })
			end)
		end,
		error = function(_) end, -- ignore errors
	}

	require("utils.fs").read_file_async(path, callback)
end

return M
