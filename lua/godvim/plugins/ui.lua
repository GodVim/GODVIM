return {
  -- Notifications
  {
    "echasnovski/mini.notify",
    event = "User FilePost",
    opts = {
      lsp_progress = {
        enable = false
      }
    },
  },

  {
    "rose-pine/neovim",
    event = "VimEnter",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        varient = "moon",
        styles = {
          transparency = true,
        },
      })
      vim.cmd("colorscheme rose-pine")
    end
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "User FilePost",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {}
  },
return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "  ███╗   ███╗██████╗ ███████╗████████╗███████╗██████╗ ",
        "  ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗",
        "  ██╔████╔██║██████╔╝███████╗   ██║   █████╗  ██████╔╝",
        "  ██║╚██╔╝██║██╔═══╝ ╚════██╗  ██║   ██╔══╝  ██╔══██╗",
        "  ██║ ╚═╝ ██║██║     ███████╗  ██║   ███████╗██║  ██║",
        "  ╚═╝     ╚═╝╚═╝     ╚══════╝  ╚═╝   ╚══════╝╚═╝  ╚═╝",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("n", "  New File", ":ene | startinsert<CR>"),
        dashboard.button("g", "  Find Text", ":Telescope live_grep<CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("c", "  Config", ":e $MYVIMRC | startinsert<CR>"),
        dashboard.button("s", "  Restore Session", ":SessionManager load_last_session<CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = "Welcome to Neovim!"

      alpha.setup(dashboard.config)
    end,
  },
}

	-- Dashboard
	{
		"folke/snacks.nvim",
		event = "UiEnter",
		enabled = false,
		
		opts = {
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "l",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},
  
}
