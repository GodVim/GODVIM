return {
  "folke/which-key.nvim",
  event = "BufReadPre",
  opts = function()
    local wk = require("which-key")
    wk.setup({ preset = "helix" })

    wk.add({
      ----- Groups -----
      { "<leader>c",  group = "Code" },
      { "<leader>b",  group = "Buffers" },
      { "<leader>s",  group = "Sessions" },
      { "<leader>f",  group = "Find" },
      { "<leader>d",  group = "Debug" },

      ----- Buffers -----
      { "<leader>bd", "<cmd>bdelete<cr>",                                         desc = "Close buffer" },
      { "<leader>bn", "<cmd>enew<cr>",                                            desc = "New buffer" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>",                               desc = "Switch buffer" },
      { "<leader>bf", "<cmd>lua require('conform').format({ async = true })<cr>", desc = "Format Buffer" },

      { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                             desc = "Grep" },
      { "<leader>fb", "<cmd>Telescope Buffers<cr>",                               desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                             desc = "Help" },
      { "<leader>fr", '<cmd>lua require("ssr").open()<cr>',                       desc = "Replace" },

      {
        "<leader>ca",
        "<cmd>lua require('actions-preview').code_actions()<cr>",
        desc = "Code Action",
        mode = { "n", "v" },
      },

      { "<leader>a", "<cmd>Themify<cr>",                          desc = "Themes" },
      { "<leader>e", "<cmd>lua require('mini.files').open()<cr>", desc = "File Explorer" },
    })
  end
}
