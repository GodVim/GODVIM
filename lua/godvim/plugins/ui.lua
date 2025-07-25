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
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = false,
        },
      }
      vim.cmd("colorscheme rose-pine")
    end
  },

}
