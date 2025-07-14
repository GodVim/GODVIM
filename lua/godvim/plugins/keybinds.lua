return {
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
	
				----- Code -----
				{
					"<leader>ca",
					"<cmd>lua require('tiny-code-action').code_action()<cr>",
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
	
