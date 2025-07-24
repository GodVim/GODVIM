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
	

-- add this to the file where you setup your other plugins:
{
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    vim.keymap.set("i", "<A-f>", neocodeium.accept)
local blink = require('blink.cmp')

vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function()
    neocodeium.clear()
  end,
})

neocodeium.setup({
  filter = function()
    return not blink.is_visible()
  end,
})
  end,
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
				default = { "copilot", "snippets", "lsp", "ripgrep" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
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
