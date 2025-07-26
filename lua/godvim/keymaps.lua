local map = vim.keymap.set

-- Window navigation with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })


-- Moving lines and preserving indentation
map('n', '<C-J>', "<cmd>move .+1<cr>==")
map('n', '<A-k>', "<cmd>move .-2<cr>==")
map('x', '<A-j>', "<esc><cmd>'<,'>move '>+1<cr>gv=gv")
map('x', '<A-k>', "<esc><cmd>'<,'>move '<-2<cr>gv=gv")


-- change font
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })


-- better search
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })


-- why does it copy when i wanna delete?
map({'n', 'x'}, 'c', '"_c')
map({'n', 'x'}, 'x', '"_x')
map({'n', 'x'}, 'X', '"_d')


-- Misc.
map('n', '<F8>', "<cmd>Jaq<cr>", { noremap = true, silent = true })
map('n', 'r', '<C-r>')
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

map('n', '<leader><space>', '<cmd>ls<cr>:buffer ')
