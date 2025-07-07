return {
  -- General LSP-related plugins
  { "neovim/nvim-lspconfig", event = "VeryLazy" }, -- Load lspconfig plugin early

  -- Mason: Manages LSP server installations (and other tools)
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
    version = "^1.0.0",
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    version = "^1.0.0",
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "jsonls",
        "biome",
        "astro",
        "markdown-toc",
        "prettier",
        "stylua",
        "tailwindcss",
        "marksman",
      }
    }
  },

  {
    "nvim-java/nvim-java",
    ft = "java",
    config = function()
      require("java").setup({
        jdk = {
          auto_install = false,
        },
      })
      require("lspconfig").jdtls.setup({})
    end,
  },
}

