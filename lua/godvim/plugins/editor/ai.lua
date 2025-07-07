return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
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
