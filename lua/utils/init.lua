local M = {}

M.paste_from_primary_clipboard = require("utils.clipboard").paste
M.copy_to_primary_clipboard = require("utils.clipboard").copy
M.close_other_buffers = require("utils.buffers").close_other_buffers
M.do_diff_hunk_under_cursor = require("utils.diff").do_diff_hunk_under_cursor
M.apply_code_action = require("utils.lsp").apply_code_action
M.smart_backspace = require("utils.backspace").smart_backspace
M.map = require("utils.map").map

return M
