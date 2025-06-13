if false then return {  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
    exclude = {
      filetypes = {
        "Trouble",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "mason",
        "neo-tree",
        "notify",
        "snacks_dashboard",
        "snacks_notif",
        "snacks_terminal",
        "snacks_win",
        "toggleterm",
        "trouble",
      },
    },
  },
  main = "ibl",
}
end

return {
  {
    "nvimdev/indentmini.nvim",
    opts ={},
    event = "InsertEnter"
  }
}
