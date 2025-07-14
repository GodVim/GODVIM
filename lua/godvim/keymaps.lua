--[[
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

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Buffers
map("n", "<leader>bd", "<cmd>bdelete!<cr>", { desc = "Close buffer", silent = true })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer", silent = true })
map("n", "<leader>bb", function() Snacks.picker.buffers() end, { desc = "Switch buffer" })

-- Snacks Picker
map("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Files" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>st", function() require("nvchad.themes").open() end, { desc = "Themes" })

-- Code
map("n", "<leader>cg", "<cmd>Jaq<cr>", { desc = "Run", silent = true })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

-- Random stuff
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })

map("n", "<leader>t", function() Snacks.terminal.toggle() end, { desc = "Terminal" })
map("n", "<leader>e", function() require("mini.files").open() end, { desc = "File Explorer" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy", silent = true })

map("n", "<leader>ca", "<cmd>lua require('actions-preview').code_actions()<cr>", { desc = "Code Action" })
map({ "v", "n" }, "gf", "<cmd>lua require('actions-preview').code_actions()<cr>")

map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })




map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
]]--
local wk = require("which-key")

-- add key mappings with v3 spec
wk.add({
  -- Terminal escape
  { "<Esc>",       "<C-\\><C-n>",           desc = "Escape terminal", mode = "t" },

  -- Normal mode window navigation
  { "<C-h>",       "<C-w>h",                 desc = "Go to left window" },
  { "<C-j>",       "<C-w>j",                 desc = "Go to lower window" },
  { "<C-k>",       "<C-w>k",                 desc = "Go to upper window" },
  { "<C-l>",       "<C-w>l",                 desc = "Go to right window" },

  -- Copy whole file
  { "<C-c>",       "<cmd>%y+<CR>",           desc = "Copy whole file" },

  -- Jaq / run code
  { "<F8>",        "<cmd>Jaq<cr>",           desc = "Jaq (run)" },

  -- j/k remap for wrapped lines
  { "j",           "v:count == 0 ? 'gj' : 'j'", desc = "Down", expr = true, mode = {"n","x"} },
  { "<Down>",      "v:count == 0 ? 'gj' : 'j'", desc = "Down", expr = true, mode = {"n","x"} },
  { "k",           "v:count == 0 ? 'gk' : 'k'", desc = "Up",   expr = true, mode = {"n","x"} },
  { "<Up>",        "v:count == 0 ? 'gk' : 'k'", desc = "Up",   expr = true, mode = {"n","x"} },

  -- Resize windows
  { "<C-Up>",      "<cmd>resize +2<cr>",     desc = "Increase window height" },
  { "<C-Down>",    "<cmd>resize -2<cr>",     desc = "Decrease window height" },
  { "<C-Left>",    "<cmd>vertical resize -2<cr>", desc = "Decrease window width" },
  { "<C-Right>",   "<cmd>vertical resize +2<cr>", desc = "Increase window width" },

  -- Move lines up/down in normal, insert, visual
  { "<A-j>",       "<cmd>execute 'move .+' . v:count1<cr>==",desc = "Move down", mode = "n" },
  { "<A-k>",       "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move up", mode = "n" },
  { "<A-j>",       "<esc><cmd>m .+1<cr>==gi", desc = "Move down", mode = "i" },
  { "<A-k>",       "<esc><cmd>m .-2<cr>==gi", desc = "Move up", mode = "i" },
  { "<A-j>",       ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", desc = "Move down", mode = "v" },
  { "<A-k>",       ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", desc = "Move up", mode = "v" },

  -- Search result navigation
  { "n",           "'Nn'[v:searchforward].'zv'", desc = "Next Search Result", expr = true, mode = {"n","x","o"} },
  { "N",           "'nN'[v:searchforward].'zv'", desc = "Prev Search Result", expr = true, mode = {"n","x","o"} },

  -- Save file
  { "<C-s>",       "<cmd>w<cr><esc>",        desc = "Save file", mode = {"n","i","x","s"} },

  -- Leader key groups
  -- Buffers:
  { "<leader>bd", "<cmd>bdelete!<cr>",      desc = "Close buffer" },
  { "<leader>bn", "<cmd>enew<cr>",          desc = "New buffer" },
  { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Switch buffer" },

  -- Search/File:
  { "<leader>sf", function() Snacks.picker.files() end, desc = "Files" },
  { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },
  { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<leader>st", function() require("nvchad.themes").open() end, desc = "Themes" },

  -- Code:
  { "<leader>cg",   "<cmd>Jaq<cr>",         desc = "Run" },
  { "<leader>cr",   vim.lsp.buf.rename,     desc = "Rename" },
  { "<leader>cf",   vim.lsp.buf.format,     desc = "Format" },
  { "<leader>ca",   "<cmd>lua require('actions-preview').code_actions()<cr>", desc = "Code Action" },

  -- Misc:
  { "<leader>,",    function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>/",    function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>:",    function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>t",    function() Snacks.terminal.toggle() end, desc = "Terminal" },
  { "<leader>e",    function() require("mini.files").open() end, desc = "File Explorer" },
  { "<leader>l",    "<cmd>Lazy<cr>",        desc = "Lazy" },

  -- LSP and misc
  { "gD",           vim.lsp.buf.declaration, desc = "Go to declaration" },
  { "gf",           "<cmd>lua require('actions-preview').code_actions()<cr>", desc = "Code Action" },

  -- Clear highlights
  { "<Esc>",        "<cmd>noh<CR>",         desc = "Clear highlights" },
})
