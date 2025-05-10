vim.api.nvim_create_user_command("SetFiletype", function(opts)
	if opts.fargs[1] then
		vim.bo.filetype = opts.fargs[1]
		return
	end

	require("util.filetype").select_filetype()
end, {
	nargs = "?",
	complete = function(arg_lead)
		local filetypes = require("util.filetype").known_filetypes()

		return vim.tbl_filter(function(value)
			return vim.startswith(value, arg_lead)
		end, filetypes)
	end,
})
