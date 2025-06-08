return {
  "lmantw/themify.nvim",
  lazy = true,
  opts = {
    {
      "folke/tokyonight.nvim",
      blacklist = { "tokyonight-day", "tokyonight-storm" },
    },
    {
      "everviolet/nvim",
      branch = "mega",
      blacklist = { "evergarden-winter", "evergarden-spring" },
    },
    {
      "catppuccin/nvim",
      blacklist = { "catppuccin-latte", "catppuccin-mocha" },
    },
    {
      "rose-pine/neovim",
      blacklist = { "rose-pine-dawn", "rose-pine-moon" },
    },
    "navarasu/onedark.nvim",
    "EdenEast/nightfox.nvim",
    "loctvl842/monokai-pro.nvim",
    "default"
  }
}
