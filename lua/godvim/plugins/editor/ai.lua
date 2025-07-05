return {
  "zbirenbaum/copilot.lua",
  ft = { "astro", "ts" },
  build = ":Copilot auth",
  cmd = "Copilot",
  opts = {
    suggestion = {
      enabled = false,
    },
    panel = {
      enabled = false
    },
    filetypes = {
      markdown = true,
      help = true
    }
  }
}
