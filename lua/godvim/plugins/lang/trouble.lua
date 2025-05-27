return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>cx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
  },
}
