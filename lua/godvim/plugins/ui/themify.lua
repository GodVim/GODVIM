return {

  "lmantw/themify.nvim",
  priority = 999,
  event = "UiEnter",
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
    {
      "rmehri01/onenord.nvim",
      branch = "main",
      blacklist = { "onenord-light" },
    },
    "navarasu/onedark.nvim",
    "gbprod/nord.nvim",
    "EdenEast/nightfox.nvim",
    "sainnhe/sonokai",
    "loctvl842/monokai-pro.nvim",
    "default"
  }
}
