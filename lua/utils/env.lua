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
		line = vim.trim(line)

		if line ~= "" then
			local name, value = unpack(vim.split(line, "="))

			variables[name] = H.normalize_value(value)
		end
	end

	return variables
end

---@param value string
---@return string
function H.normalize_value(value)
	-- remove quotes
	value = value:match("^[\"']*(.*[^\"'])") or ""

	-- TODO: remove escape symbols

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

				require("utils.notify").add(string.format("Loaded %q", path), 2000)
			end)
		end,
		error = function(_) end, -- ignore errors
	}

	require("utils.fs").read_file_async(path, callback)
end

return M
