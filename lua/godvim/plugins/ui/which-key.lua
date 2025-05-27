return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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
      { "<leader>t",  group = "Todos" },

      ----- Buffers -----
      { "<leader>bd", "<cmd>bdelete<cr>",                                         desc = "Close buffer" },
      { "<leader>bn", "<cmd>enew<cr>",                                            desc = "New buffer" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>",                               desc = "Switch buffer" },
      { "<leader>bf", "<cmd>lua require('conform').format({ async = true })<cr>", desc = "Format Buffer" },

      ----- Telescope -----
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                             desc = "Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                               desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                             desc = "Help" },
      { "<leader>fr", '<cmd>lua require("ssr").open()<cr>',                       desc = "Replace" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                                   desc = "Todo" },

      ----- Todos -----
      { "<leader>ts", "<cmd>TodoQuickFix<cr>",                                    desc = "List todos" },
      { "<leader>tl", "<cmd>Trouble todo<cr>",                                    desc = "Outline todos" },

      ----- Code -----
      { "<leader>cr", "<cmd>RunCode<cr>",                                         desc = "Run" },
      {
        "<leader>ca",
        "<cmd>lua require('actions-preview').code_actions()<cr>",
        desc = "Code Action",
      },

      ----- random stuff -----

      { "<leader>a", "<cmd>Themify<cr>",                          desc = "Themes" },
      { "<leader>e", "<cmd>lua require('mini.files').open()<cr>", desc = "File Explorer" },
    })
  end
}
