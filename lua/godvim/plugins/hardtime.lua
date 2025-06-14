return {
   "m4xshen/hardtime.nvim",
   event = "UiEnter",
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {
      disabled_keys = {
         ["<Up>"] = false,
         ["<Down>"] = false,
         ["<Left>"] = false,
         ["<Right>"] = false
      }
   },
}
