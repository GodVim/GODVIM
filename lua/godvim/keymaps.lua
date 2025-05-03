-- Map Esc to escape from terminal insert mode to normal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
