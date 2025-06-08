return {
  { "neovim/nvim-lspconfig", event = "BufReadPre" },
  { "zeioth/garbage-day.nvim", event = "LspAttach" },
  {"mason-org/mason-lspconfig.nvim", lazy = true, version = "^1.0.0"},
  {
    "mason-org/mason.nvim",
    event = "BufReadPre",
    version = "^1.0.0",
    config = function()
      local mason = require("mason")

      mason.setup({
        registries = {
          "github:nvim-java/mason-registry@2024-12-24-graceful-raft",
          "github:mason-org/mason-registry@2025-05-10-new-sprout"
        }
      })

      local servers = {
        "lua_ls",
        "jsonls",
        "jdtls",
        "yamlls",
        "pyright",
        "marksman"
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers
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
          auto_install = false
        }
      })
      lspconfig.jdtls.setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = "lua",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = "lua",
    config = function()
      require("lspconfig").lua_ls.setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = "json",
    config = function()
      require("lspconfig").jsonls.setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = "yaml",
    config = function()
      require("lspconfig").yamlls.setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = "py",
    config = function()
      require("lspconfig").pyright.setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = "md",
    config = function()
      require("lspconfig").marksman.setup({})
    end
  }
}
