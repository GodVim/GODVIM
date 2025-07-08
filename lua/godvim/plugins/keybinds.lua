return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    defaults = {},
    spec = {
      ----- Groups -----
      { "<leader>c",  group = "Code" },
      { "<leader>b",  group = "Buffers" },
      { "<leader>s",  group = "Sessions" },
      { "<leader>f",  group = "Find" },
      { "<leader>d",  group = "Debug" },

      ----- Buffers -----
      { "<leader>bd", "<cmd>bdelete!<cr>",                                        desc = "Close buffer" },
      { "<leader>bn", "<cmd>enew<cr>",                                            desc = "New buffer" },
      { "<leader>bb", "<cmd>lua Snacks.picker.buffers()<cr>",                     desc = "Switch buffer" },

      ----- Telescope -----
      { "<leader>fc", "<cmd>Themify<cr>",                                         desc = "Themes" },
      { "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>",                       desc = "Files" },
      { "<leader>fg", "<cmd>lua Snacks.picker.grep()<cr>",                        desc = "Grep" },
      { "<leader>fb", "<cmd>lua Snacks.picker.buffers()<cr>",                     desc = "Buffers" },
      { "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>",                        desc = "Help" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                                   desc = "Todo" },

      ----- Code -----
      {
        "<leader>ca",
        "<cmd>lua require('tiny-code-action').code_action()<cr>",
        desc = "Code Action",
      },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename"},

      ----- random stuff -----
      { "<leader>t", "<cmd>FloatermToggle<cr>",                                   desc = "Terminal" },
      { "<leader>e", "<cmd>lua require('mini.files').open()<cr>",                 desc = "File Explorer" },
      { "<leader>l", "<cmd>Lazy<cr>",                                             desc = "Lazy" },
      { "<leader>lg", "<cmd>lua Snacks.lazygit.open()<cr>",                       desc = "Lazygit" },
    }
  }
}
