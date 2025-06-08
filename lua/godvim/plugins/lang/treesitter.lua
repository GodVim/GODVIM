return {
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = {
    }
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "astro", "html", "javascript", "jsx", "markdown", "svelte", "tsx", "typescript", "xml" },
    opts = {}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "gitignore",
        "java",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
  
}
