return {
	-- Pairs
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		version = false,
		opts = {},
	},
	-- Commenting
	{
		"echasnovski/mini.comment",
		event = "User FilePost",
		version = false,
		opts = {},
	},

	-- Surround
	{
		"echasnovski/mini.surround",
		event = "InsertEnter",
		version = false,
		opts = {},
	},

	{
		"echasnovski/mini.snippets",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = false,
		config = function()
			local gen_loader = require("mini.snippets").gen_loader
			require("mini.snippets").setup({
				snippets = {
					gen_loader.from_file("~/.config/nvim/snippets/global.json"),

					gen_loader.from_lang(),
				},
			})
		end,
	},
	{
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = "InsertEnter",
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = vim.g.ai_cmp,
    virtual_text = {
      enabled = not vim.g.ai_cmp,
      key_bindings = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
  },
},

	
	{
		"Saghen/blink.cmp",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				build = ":Copilot auth",
				cmd = "Copilot",
				opts = {
					filetypes = {
						markdown = true,
						help = true,
					},
				},
			},
			"codeium.nvim", "saghen/blink.compat"
			"mikavilpas/blink-ripgrep.nvim",
			"giuxtaposition/blink-cmp-copilot",
		},
		event = {
			"User FilePost",
			"CmdlineChanged",
		},
	version = "*",

		opts = {
			keymap = { preset = "super-tab" },
			snippets = { preset = "mini_snippets" },
			cmdline = {
				completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
			},
			completion = {
				list = {
					selection = { auto_insert = false },
				},
			},
			sources = {
				      compat = { "codeium" },

				default = { "copilot", "snippets", "lsp", "ripgrep" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
					        codeium = {
          kind = "Codeium",
          score_offset = 100,
          async = true,
        },
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						score_offset = -4,
						opts = {
							prefix_mix_len = 3,
							context_size = 5,
							max_filesize = "1M",
						},
					},
				},
			},
		},
	},
}
