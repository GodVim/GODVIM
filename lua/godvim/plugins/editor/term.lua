local current = 2
return {
	"CRAG666/betterTerm.nvim",
	keys = {
		{
			mode = { "n", "t" },
			"<leader>t",
			function()
				require("betterTerm").open()
			end,
			desc = "Open terminal",
		},
		{
			"<leader>ft",
			function()
				require("betterTerm").select()
			end,
			desc = "Select terminal",
		},
	},
	opts = {
		position = "bot",
		size = 15,
	},
	-- config = true,
}
