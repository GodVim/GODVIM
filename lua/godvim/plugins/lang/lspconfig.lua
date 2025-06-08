return {
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
          --"ruff",
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
  {"mason-org/mason-lspconfig.nvim", lazy = true, version = "^1.0.0"},
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
        event = "BufReadPre",
        dependencies = {
            "zeioth/garbage-day.nvim"
        },
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({})
            lspconfig.jsonls.setup({})
            -- lspconfig.ruff.setup({})
            lspconfig.yamlls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.marksman.setup({})
        end
    }
}
