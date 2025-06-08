return {
  -- General LSP-related plugins
  { "neovim/nvim-lspconfig", event = "BufReadPre" }, -- Load lspconfig plugin early
  { "zeioth/garbage-day.nvim", event = "LspAttach" },

  -- Mason: Manages LSP server installations (and other tools)
  {
    "mason-org/mason.nvim",
    event = "BufReadPre", -- Load Mason early so it can manage installations
    version = "^1.0.0",
    config = function()
      require("mason").setup({
        registries = {
          "github:nvim-java/mason-registry@2024-12-24-graceful-raft",
          "github:mason-org/mason-registry@2025-05-10-new-sprout",
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
        "jdtls", -- Mason-lspconfig will ensure jdtls is installed
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers, -- Ensures these servers are installed
        -- This 'handlers' table is crucial. It tells mason-lspconfig how to
        -- configure each server.
        handlers = {
          -- Default handler: For most servers, we just call lspconfig.<server>.setup({})
          -- This will automatically activate the server when the relevant filetype is opened.
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          -- Specific handler for jdtls:
          -- We explicitly *don't* want mason-lspconfig to call jdtls.setup({})
          -- here because nvim-java will handle it with its own custom setup.
          -- You could also just omit "jdtls" from the `servers` list if you
          -- prefer nvim-java to be the sole manager of jdtls installation/setup.
          -- However, keeping it in `ensure_installed` ensures mason manages the binary.
          -- The nvim-java plugin below will then provide the specific `jdtls.setup` call.
        },
      })
    end,
  },

  -- nvim-java: Specialized setup for Java (including jdtls)
  {
    "nvim-java/nvim-java",
    lazy = true,
    ft = "java", -- Only load this plugin when a Java file is opened
    config = function()
      require("java").setup({
        jdk = {
          auto_install = false, -- As per your original config
        },
      })
      -- This is where `jdtls` is specifically configured when a Java file is opened.
      -- This setup will take precedence or integrate with mason-lspconfig's installation.
      require("lspconfig").jdtls.setup({})
    end,
  },
}

