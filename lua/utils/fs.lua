local M = {}

---@param path string
---@param callback {success: fun(data: string), error: fun(err: string)?}
function M.read_file_async(path, callback)
	callback.error = callback.error or error

	local uv = vim.uv

	uv.fs_open(path, "r", 438, function(err, fd)
		if err ~= nil then
			callback.error(err)
			return
		end

		---@diagnostic disable-next-line: redefined-local
		uv.fs_fstat(fd, function(err, stat)
			if err ~= nil then
				callback.error(err)
				return
			end
			assert(stat ~= nil)

			---@diagnostic disable-next-line: redefined-local
			uv.fs_read(fd, stat.size, 0, function(err, data)
				if err ~= nil then
					callback.error(err)
					return
				end
				assert(data ~= nil)

				callback.success(data)

				-- ignore close error
				uv.fs_close(fd, function() end)
			end)
		end)
	end)
end

return M
