return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
      preset = "helix"
    },
  keys = {
      ----- Groups -----
      { "<leader>c",  group = "Code" },
      { "<leader>b",  group = "Buffers" },
      { "<leader>s",  group = "Sessions" },
      { "<leader>f",  group = "Find" },
      { "<leader>d",  group = "Debug" },

      ----- Buffers -----
      { "<leader>bd", "<cmd>bdelete!<cr>",                                        desc = "Close buffer" },
      { "<leader>bn", "<cmd>enew<cr>",                                            desc = "New buffer" },
      { "<leader>bb", "<cmd>FzfLua buffers<cr>",                                  desc = "Switch buffer" },
      { "<leader>bf", "<cmd>lua require('conform').format({ async = true })<cr>", desc = "Format Buffer" },

      ----- Telescope -----
      { "<leader>fc", "<cmd>Themify<cr>",                                         desc = "Themes" },
      { "<leader>ff", "<cmd>FzfLua files<cr>",                                    desc = "Files" },
      { "<leader>fg", "<cmd>FzfLua grep<cr>",                                     desc = "Grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",                                  desc = "Buffers" },
      { "<leader>fh", "<cmd>FzfLua helptags<cr>",                                 desc = "Help" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                                   desc = "Todo" },

      ----- Code -----
      { "<leader>cr", "<cmd>OverseerRun<cr>",                                     desc = "Run" },
      {
        "<leader>ca",
        "<cmd>lua require('tiny-code-action').code_action()<cr>",
        desc = "Code Action",
      },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename"},

      ----- random stuff -----
      { "<leader>t", "<cmd>FloatermToggle<cr>",                                   desc = "Terminal" },
      { "<leader>e", "<cmd>lua require('mini.files').open()<cr>",                 desc = "File Explorer" },
      { "<leader>l", "<cmd>Lazy<cr>",                                             desc = "Lazy" }
  }
--  opts = function()
--    local wk = require("which-key")

--    wk.add({
      ----- Groups -----
 --     { "<leader>c",  group = "Code" },
 --     { "<leader>b",  group = "Buffers" },
 --     { "<leader>s",  group = "Sessions" },
 --     { "<leader>f",  group = "Find" },
 --     { "<leader>d",  group = "Debug" },

      ----- Buffers -----
 --     { "<leader>bd", "<cmd>bdelete!<cr>",                                        desc = "Close buffer" },
 --     { "<leader>bn", "<cmd>enew<cr>",                                            desc = "New buffer" },
 --     { "<leader>bb", "<cmd>FzfLua buffers<cr>",                                  desc = "Switch buffer" },
 --     { "<leader>bf", "<cmd>lua require('conform').format({ async = true })<cr>", desc = "Format Buffer" },

      ----- Telescope -----
 --     { "<leader>fc", "<cmd>Themify<cr>",                                         desc = "Themes" },
 --     { "<leader>ff", "<cmd>FzfLua files<cr>",                                    desc = "Files" },
 --     { "<leader>fg", "<cmd>FzfLua grep<cr>",                                     desc = "Grep" },
 --     { "<leader>fb", "<cmd>FzfLua buffers<cr>",                                  desc = "Buffers" },
 --     { "<leader>fh", "<cmd>FzfLua helptags<cr>",                                 desc = "Help" },
 --     { "<leader>ft", "<cmd>TodoTelescope<cr>",                                   desc = "Todo" },

      ----- Code -----
--      { "<leader>cr", "<cmd>OverseerRun<cr>",                                     desc = "Run" },
--      {
--        "<leader>ca",
--        "<cmd>lua require('tiny-code-action').code_action()<cr>",
--        desc = "Code Action",
 --     },
--      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename"},

--      ----- random stuff -----
--      { "<leader>t", "<cmd>FloatermToggle<cr>",                                   desc = "Terminal" },
--      { "<leader>e", "<cmd>lua require('mini.files').open()<cr>",                 desc = "File Explorer" },
--      { "<leader>l", "<cmd>Lazy<cr>",                                             desc = "Lazy" },
--    })
--    return {
--      preset = "helix"
 --   }
--  end
}
