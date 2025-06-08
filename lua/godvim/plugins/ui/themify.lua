return {
  "lmantw/themify.nvim",
  lazy = true,
  cmd = "Themify",
  opts = {
    {
      "folke/tokyonight.nvim",
      blacklist = { "tokyonight-day", "tokyonight-storm" },
    },
    {
      "catppuccin/nvim",
      blacklist = { "catppuccin-latte", "catppuccin-mocha" },
    },
    {
      "rose-pine/neovim",
      blacklist = { "rose-pine-dawn", "rose-pine-moon" },
    },
    {
      "loctvl842/monokai-pro.nvim",
      blacklist = { "monokai-pro-spectrum", "monokai-pro-octagon", "monokai-pro-machine", "monokai-pro-light" }, 
    },
    "default"
  }
}
