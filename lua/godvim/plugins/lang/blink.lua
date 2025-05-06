return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"Saghen/blink.cmp",
		dependencies = {
			"mikavilpas/blink-ripgrep.nvim",
		},
		event = {
			"InsertEnter",
			"CmdlineEnter",
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "mini_snippets" },
			keymap = { preset = "enter" },
			snippets = { preset = "mini_snippets" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				documentation = { auto_show = true },
				ghost_text = { enabled = false },
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"ripgrep",
					"lazydev",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						score_offset = -4,
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
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
