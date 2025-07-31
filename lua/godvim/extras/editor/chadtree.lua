return {
  {
    "ms-jpq/chadtree",
    branch = "chad",
    build = "python3 -m chadtree deps",
    cmd = { "CHADopen", "CHADclose", "CHADtoggle" },
    keys = {
      { "<leader>e", "<cmd>CHADopen<CR>", desc = "Open CHADTree" },
    },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  }
}
