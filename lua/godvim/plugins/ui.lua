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
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {}
  }


}
