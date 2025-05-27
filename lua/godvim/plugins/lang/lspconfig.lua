return {

  {
    lazy = true,
    "williamboman/mason-lspconfig",
  --   version = "^1.0.0" 
  },
--  {
--    "nvim-java/nvim-java",
--    ft = "java",
--    dependencies = {
--      {
--        "nvim-java/nvim-java-core",
--        url = "https://github.com/Kabil777/nvim-java-core.git",
--        branch = "fix/mason-api-update",
--      },
--    },
--  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "zeioth/garbage-day.nvim",
      {
        "mason-org/mason.nvim",
--         version = "^1.0.0",
--        opts = {
--          registries = {
--            'github:nvim-java/mason-registry@2024-12-24-graceful-raft',
--            'github:mason-org/mason-registry@2025-05-10-new-sprout',
--          },
--        },
      },

    },
    config = function()
      local mason = require("mason")
      local lspconfig = require("lspconfig")

      mason.setup()

      local servers = {
        "lua_ls",
        "ruff",
        "jsonls",
        "jdtls",
        "yamlls",
        "pyright",
        "marksman",
      }


      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })


--      require("java").setup({
--        jdk = {
--          auto_install = false,
--        },
--      })

--      require("lspconfig").jdtls.setup({
--        handlers = {
          -- By assigning an empty function, you can remove the notifications
          -- printed to the cmd
--          ["$/progress"] = function(_, result, ctx) end,
--        },
--      })

      lspconfig.jdtls.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.ruff.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.marksman.setup({})
    end,
  }
}

