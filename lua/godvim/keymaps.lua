local map = vim.keymap.set

-- Map Esc to escape from terminal insert mode to normal mode
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Window navigation with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
map('n', 'r', '<C-r>')

-- Moving lines and preserving indentation
vim.keymap.set('n', '<C-j>', "<cmd>move .+1<cr>==")
vim.keymap.set('n', '<C-k>', "<cmd>move .-2<cr>==")
vim.keymap.set('x', '<C-j>', "<esc><cmd>'<,'>move '>+1<cr>gv=gv")
vim.keymap.set('x', '<C-k>', "<esc><cmd>'<,'>move '<-2<cr>gv=gv")


map('n', '<F8>', "<cmd>Jaq<cr>", { noremap = true, silent = true })


map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })


map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
