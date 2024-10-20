local M = {}

-- Close all listed and non-terminal buffers based on filter
---@param filter fun(buf: integer): boolean
---@param opts vim.api.keyset.buf_delete
function M.close_buffers(filter, opts)
	local _filter = function(buf)
		return M.is_visible(buf) and filter(buf)
	end

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if _filter(buf) then
			vim.api.nvim_buf_delete(buf, opts)
		end
	end

	vim.cmd.redrawtabline()
end

---@param opts vim.api.keyset.buf_delete
function M.close_other_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	M.close_buffers(function(buf)
		return buf ~= current
	end, opts)
end

function M.close_right_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	M.close_buffers(function(buf)
		return buf > current
	end, opts)
end

function M.close_left_buffers(opts)
	local current = vim.api.nvim_get_current_buf()

	M.close_buffers(function(buf)
		return buf < current
	end, opts)
end

---@return Iter
function M.list()
	return vim.iter(vim.api.nvim_list_bufs()):filter(M.is_visible)
end

---@param buf integer
---@return boolean
function M.is_visible(buf)
	local is_visible = vim.bo[buf].buflisted
	local is_terminal = vim.bo[buf].filetype == "toggleterm"

	return is_visible and not is_terminal
end

return M
