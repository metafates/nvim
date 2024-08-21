local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("i", "jk", "<Esc>")
map("n", ",w", ":w<CR>")
map("n", ",q", ":q<CR>")
map("n", ",Q", ":q!<CR>")
map("n", ",x", ":x<CR>")
map("n", ",c", ":bd<CR>", { silent = true })
map("n", ",C", ":bd!<CR>", { silent = true })
map("n", "L", ":bnext<CR>", { silent = true })
map("n", "H", ":bprevious<CR>", { silent = true })
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- toggle comments
map("n", "<C-c>", "gcc<DOWN>", { remap = true })
map("v", "<C-c>", "gc", { remap = true })

map("n", "U", ":redo<CR>", { silent = true })

map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map({ "i", "n" }, "<C-r>", ":set wrap!<CR>", { silent = true })
