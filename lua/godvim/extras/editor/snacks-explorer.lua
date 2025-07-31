return {
  {
    "folke/snacks.nvim",
    cmd = "Snacks",
    keys = {
      { "<leader>e", function() require("snacks").explorer() end, desc = "Snacks Explorer" },
    },
    opts = {
      explorer = { enabled = true },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  }
}
