local H = {}
local M = {}

function H.parse_line(linenr)
	local bufnr = vim.api.nvim_get_current_buf()

	local line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
	if not line then
		return nil
	end

	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok then
		return nil
	end

	local query = vim.treesitter.query.get(parser:lang(), "highlights")
	if not query then
		return nil
	end

	local tree = parser:parse({ linenr - 1, linenr })[1]

	local result = {}

	local line_pos = 0

	for id, node, metadata in query:iter_captures(tree:root(), 0, linenr - 1, linenr) do
		local name = query.captures[id]
		local start_row, start_col, end_row, end_col = node:range()

		local priority = tonumber(metadata.priority or vim.highlight.priorities.treesitter)

		if start_row == linenr - 1 and end_row == linenr - 1 then
			-- check for characters ignored by treesitter
			if start_col > line_pos then
				table.insert(result, {
					line:sub(line_pos + 1, start_col),
					{ { "Folded", priority } },
					range = { line_pos, start_col },
				})
			end
			line_pos = end_col

			local text = line:sub(start_col + 1, end_col)
			table.insert(result, { text, { { "@" .. name, priority } }, range = { start_col, end_col } })
		end
	end

	local i = 1
	while i <= #result do
		-- find first capture that is not in current range and apply highlights on the way
		local j = i + 1
		while j <= #result and result[j].range[1] >= result[i].range[1] and result[j].range[2] <= result[i].range[2] do
			for k, v in ipairs(result[i][2]) do
				if not vim.tbl_contains(result[j][2], v) then
					table.insert(result[j][2], k, v)
				end
			end
			j = j + 1
		end

		-- remove the parent capture if it is split into children
		if j > i + 1 then
			table.remove(result, i)
		else
			-- highlights need to be sorted by priority, on equal prio, the deeper nested capture (earlier
			-- in list) should be considered higher prio
			if #result[i][2] > 1 then
				table.sort(result[i][2], function(a, b)
					return a[2] < b[2]
				end)
			end

			result[i][2] = vim.tbl_map(function(tbl)
				return tbl[1]
			end, result[i][2])

			result[i] = { result[i][1], result[i][2] }

			i = i + 1
		end
	end

	return result
end

function M.text()
	local result_start = H.parse_line(vim.v.foldstart)
	if not result_start then
		return vim.fn.foldtext()
	end

	local folded = {
		{ " ", "FoldedPad" },
		{
			" " .. require("utils.text").pluralize(vim.v.foldend - vim.v.foldstart, "line") .. " ",
			"FoldedText",
		},
		{ " ", "FoldedPad" },
	}

	for _, item in ipairs(folded) do
		table.insert(result_start, item)
	end

	-- local result_end = H.parse_line(vim.v.foldend)
	-- if result_end then
	-- 	local first = result_end[1]
	-- 	result_end[1] = { vim.trim(first[1]), first[2] }
	-- 	for _, item in ipairs(result_end) do
	-- 		table.insert(result_start, item)
	-- 	end
	-- end

	return result_start
end

return M
