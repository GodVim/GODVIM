return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
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
	
