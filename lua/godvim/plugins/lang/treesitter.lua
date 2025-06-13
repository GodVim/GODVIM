return {
  {
    "windwp/nvim-ts-autotag",
    ft = { "astro", "javascript", "markdown", "svelte", "typescript" },
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
      autotag = {
        enable = true,
      },

      ensure_installed = {
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "gitignore",
        "java",
      }
    },
  },
  
}
