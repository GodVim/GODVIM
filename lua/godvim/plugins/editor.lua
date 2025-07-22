                      return {
	---@type LazySpec
{
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi toggle<cr>",
      desc = "Open yazi at the current file",
    },
    {
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
},
	
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
			preset = "helix",
			defaults = {},
			spec = {
				----- Groups -----
				{ "<leader>c", group = "Code" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>s", group = "Search" },
				{ "<leader>d", group = "Debug" },

				----- Buffers -----
				{ "<leader>bd", "<cmd>bdelete!<cr>", desc = "Close buffer" },
				{ "<leader>bn", "<cmd>enew<cr>", desc = "New buffer" },
				{ "<leader>bb", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Switch buffer" },

				----- Telescope -----
				{ "<leader>sf", "<cmd>lua Snacks.picker.files()<cr>", desc = "Files" },
				{ "<leader>sg", "<cmd>lua Snacks.picker.grep()<cr>", desc = "Grep" },
				{ "<leader>sb", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Buffers" },
				{ "<leader>sh", "<cmd>lua Snacks.picker.help()<cr>", desc = "Help" },
				{ "<leader>sm", "<cmd>lua Snacks.picker.marks()<cr>", desc = "Marks" },
				{ "<leader>st", "<cmd>lua require('nvchad.themes').open()<cr>", desc = "Themes" },
				{ "<leader>sd", "<cmd>lua Snacks.picker.diagnostics()<cr>", desc = "Diagnostics" },

				----- Code -----
				{
					"<leader>ca",
					"<cmd>lua require('actions-preview').code_actions()<cr>",
					desc = "Code Action",
				},
				{ "<leader>cg", "<cmd>Jaq<cr>", desc = "Run" },
				{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },

				----- random stuff -----
				{ "<leader>,", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Buffers" },
				{ "<leader>/", "<cmd>lua Snacks.picker.grep()<cr>", desc = "Grep" },
				{ "<leader>:", "<cmd>lua Snacks.picker.command_history()<cr>", desc = "Command History" },

				{ "<leader>t", "<cmd>lua Snacks.terminal.toggle()<cr>", desc = "Terminal" },
				{ "<leader>e", "<cmd>lua require('mini.files').open()<cr>", desc = "File Explorer" },
				{ "<leader>l", "<cmd>Lazy<cr>", desc = "Lazy" },
			},
		},
	},
	{
		"nvim-zh/better-escape.vim",
		event = "CursorMoved"
	},
}
