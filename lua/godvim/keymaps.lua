local map = vim.keymap.set

-- Map Esc to escape from terminal insert mode to normal mode
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Window navigation with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map('n', '<F8>', "<cmd>Jaq<cr>", { noremap = true, silent = true })

