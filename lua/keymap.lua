local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("i", "jk", "<Esc>")
map("n", ",w", "<cmd>w<CR>")
map("n", ",q", "<cmd>q<CR>")
map("n", ",Q", "<cmd>q!<CR>")
map("n", ",x", "<cmd>x<CR>")
map("n", ",c", "<cmd>bd<CR>", { silent = true })
map("n", ",C", "<cmd>bd!<CR>", { silent = true })

map("n", "L", "<cmd>bnext<CR>", { silent = true })
map("n", "H", "<cmd>bprevious<CR>", { silent = true })
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- toggle comments
map("n", "<C-c>", "gcc<DOWN>", { remap = true })
map("v", "<C-c>", "gc", { remap = true })

map("n", "U", "<cmd>redo<CR>", { silent = true })

map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map({ "i", "n" }, "<C-r>", "<cmd>set wrap!<CR>", { silent = true })

map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to clipboard" })

map("n", "<leader>a", "ggVG")
