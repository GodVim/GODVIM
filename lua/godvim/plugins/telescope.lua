return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    opts = {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      }
    }
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    event = "BufReadPost",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  }
}
