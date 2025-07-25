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
    "ccxnu/rosebones",
    event = "VimEnter",
    priority = 1000,
    config = function()
      require("rosebones").setup({})
      vim.cmd.colorscheme('rosebones')
      return {}
    end,
  }
}
