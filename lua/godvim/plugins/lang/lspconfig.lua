return {
  -- General LSP-related plugins
  { "neovim/nvim-lspconfig", event = "BufRead" }, -- Load lspconfig plugin early

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
    event = "BufRead",
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

