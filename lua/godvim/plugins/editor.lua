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
			},
		},
	},
	{
		"nvim-zh/better-escape.vim",
		event = "CursorMoved"
	},
}
