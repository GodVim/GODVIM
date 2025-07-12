return {
	{
		"folke/snacks.nvim",
		event = "User FilePost",
		---@type snacks.Config
		opts = {
			indent = { enabled = true },
			input = { enabled = true },
		},
	},
	{
		"folke/snacks.nvim",
		event = "UiEnter",
		---@type snacks.Config
		opts = {
			picker = { enabled = true },
		},
	},
	{
		"folke/flash.nvim",
		event = "User FilePost",
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "?", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	
	
	{
    "LunarVim/breadcrumbs.nvim",
		event = "LspAttach",
    dependencies = {
        {"SmiteshP/nvim-navic", lazy = true,},
    },


opts ={},
}
}
