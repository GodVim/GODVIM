return {
  "lmantw/themify.nvim",
  lazy = true,
  cmd = "Themify",
  opts = {
    async = true,
    activity = true,
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
    "default"
  }
}
