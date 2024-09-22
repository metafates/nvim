local M = {}

---@param filter fun(buf: integer): boolean
---@param opts vim.api.keyset.buf_delete
function M.close_buffers(filter, opts)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if filter(buf) then
			vim.api.nvim_buf_delete(buf, opts)
		end
	end

	vim.cmd.redrawtabline()
end

---@param opts vim.api.keyset.buf_delete
function M.close_other_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	M.close_buffers(function(buf)
		local is_listed = M.is_listed(buf)
		local is_current = buf == current
		local is_terminal = vim.bo[buf].filetype == "toggleterm"

		return is_listed and not is_current and not is_terminal
	end, opts)
end

---@param buf_id integer
---@return boolean
function M.is_listed(buf_id)
	return vim.bo[buf_id].buflisted
end

---@return Iter
function M.listed_buffers()
	return vim.iter(vim.api.nvim_list_bufs()):filter(M.is_listed)
end

return M
