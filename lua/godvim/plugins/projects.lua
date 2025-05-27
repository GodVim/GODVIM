return {
  "ahmedkhalf/project.nvim",
  opts = {},
  cmd = "Telescope",
  config = function()
    require("project_nvim").setup()
    require('telescope').load_extension('projects')
  end,
}
