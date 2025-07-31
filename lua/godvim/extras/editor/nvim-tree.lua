return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    opts = {}, -- using empty opts, which calls require("nvim-tree").setup({})
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
