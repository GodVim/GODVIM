return {
    {
        "folke/snacks.nvim",
        event = "User FilePost",
        ---@type snacks.Config
        opts = {
            indent = {enabled = true},
            input = {enabled = true}
        }
    },
    {
        "folke/snacks.nvim",
        event = "UiEnter",
        ---@type snacks.Config
        opts = {
            picker = { enabled = true },
        }
    },
    
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    cmd = "Outline",
    opts = {
      outline_window = {
        position = "left",
        width = 10
      },
      keymaps = {
        up_and_jump = "<up>",
        down_and_jump = "<down>",
      },
    }
  }
}
