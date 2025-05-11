return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,

  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  }
}
