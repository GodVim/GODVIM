return 	{
  desc = "Not a plugin manager, but plugin magazine 💅",
		"alex-popov-tech/store.nvim",
		dependencies = {
			"OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
		},
		cmd = "Store",
		keys = {
			{ "<leader>s", "<cmd>Store<cr>", desc = "Open Plugin Store" },
		},
		opts = {
			-- optional configuration here
		},
	}
