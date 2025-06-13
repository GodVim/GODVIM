return {
  -- General LSP-related plugins
  { "neovim/nvim-lspconfig", event = "BufReadPre" }, -- Load lspconfig plugin early

  -- Mason: Manages LSP server installations (and other tools)
  {
    "mason-org/mason.nvim",
    event = "BufReadPre", -- Load Mason early so it can manage installations
    version = "^1.0.0",
    config = function()
      require("mason").setup({
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      })
    end,
  },

  -- Mason LSPConfig: Bridges Mason installations with nvim-lspconfig setup
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true, -- This plugin will be loaded when lspconfig is activated
    version = "^1.0.0",
    config = function()
      local servers = {
        "lua_ls",
        "jsonls",
        "yamlls",
        "pyright",
        "marksman",
      }

      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = servers,
      })
    end,
  },

  {
    "nvim-java/nvim-java",
    lazy = true,
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

