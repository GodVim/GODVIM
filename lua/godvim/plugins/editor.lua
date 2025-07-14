return {
    {
        "folke/snacks.nvim",
        event = "User FilePost",
        ---@type snacks.Config
        opts = {
            indent = {enabled = true},
            input = {enabled = true}
        }
    },
    {
        "folke/snacks.nvim",
        event = "UiEnter",
        ---@type snacks.Config
        opts = {
            picker = {enabled = true}
        }
    },
    {
        "is0n/jaq-nvim",
        cmd = { "Jaq" },
        lazy = true,
        opts = {
            cmds = {
                external = {
                    markdown = "glow %",
                    python = "python3 %",
                    go = "go run %",
                    sh = "sh %"
                }
            }
        }
    },
    {
        "hedyhli/outline.nvim",
        keys = {{"<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline"}},
        cmd = "Outline",
        opts = {
            outline_window = {
                position = "left",
                width = 10
            },
            keymaps = {
                up_and_jump = "<up>",
                down_and_jump = "<down>"
            }
        }
    },
    	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
--			preset = "helix",
			defaults = {},
			spec = {
				{ "<leader>c", group = "Code" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>s", group = "Search" },
				{ "<leader>d", group = "Debug" },
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
			},
		},
	},
	{
		"nvim-zh/better-escape.vim",
		event = "CursorMoved"
	},
}
