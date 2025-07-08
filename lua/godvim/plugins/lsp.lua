return {
  -- Lsp Config
  { "neovim/nvim-lspconfig", event = "InsertEnter" }, -- Load lspconfig plugin early

  -- Mason
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
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
      max_concurrent_installers = 10,
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    }
  },

  -- Mason Lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    event = "InsertEnter",
    version = "^1.0.0",
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "jsonls",
        "biome",
        "astro",
        "tailwindcss",
        "marksman",
      }
    }
  },

  -- Java Support
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

  -- Trouble
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- Code Actions
  {
    "rachartier/tiny-code-action.nvim",
    event = "LspAttach",
    opts = {},
  },

}
