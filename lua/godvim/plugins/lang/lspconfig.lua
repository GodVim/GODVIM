return {
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", lazy = true, version = "^1.0.0" },
  { "nvim-java/nvim-java", lazy = true, },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "zeioth/garbage-day.nvim",
      {
        "mason-org/mason.nvim",
         --version = "^1.0.0",
        opts = {
          registries = {
            'github:nvim-java/mason-registry@2024-12-24-graceful-raft',
            'github:mason-org/mason-registry@2025-05-10-new-sprout',
          },
        },
      },

    },

    config = function()
      local mason = require("mason")
      local lspconfig = require("lspconfig")

      mason.setup()

      local servers = {
        "lua_ls",
        --"ruff",
        "jsonls",
        "jdtls",
        "yamlls",
        "pyright",
        "marksman",
      }


      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

require('java').setup({
  jdk = {
    auto_install = false,
  },
})
      lspconfig.jdtls.setup({})


      lspconfig.lua_ls.setup({})
      lspconfig.jsonls.setup({})
     -- lspconfig.ruff.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.marksman.setup({})
    end,
  }
}
