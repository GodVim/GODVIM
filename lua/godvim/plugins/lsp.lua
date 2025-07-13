return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- mason.nvim core
      {
        "williamboman/mason.nvim",
        version = "^1.0.0",
        opts = {},
      },

      -- mason-lspconfig for LSP servers
      {
        "williamboman/mason-lspconfig.nvim",
        version = "^1.0.0",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
          ensure_installed = {
            "lua_ls",
            "tsserver",
            "jsonls",
            "gopls",
            "jdtls",
            "yamlls",
            "tailwindcss",
            "marksman",
            "bashls",
            "astro",
          },
          automatic_installation = true,
          handlers = {
            function(server)
              require("astrolsp").lsp_setup(server)
            end,
          },
        },
        config = function(_, opts)
          require("astrolsp.mason-lspconfig").register_servers()
          require("mason-lspconfig").setup(opts)
        end,
      },

      -- mason-tool-installer for formatters/linters/tools auto install
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
          -- List of tools you want installed by mason-tool-installer
          ensure_installed = {
            "stylua",
            "prettier",
            "golangci-lint",
            "markdownlint",
            "luacheck",
            "yamllint",
            "biome",
            "taplo",
          },
          run_on_start = true,
        },
        config = function(_, opts)
          require("mason-tool-installer").setup(opts)
        end,
      },

      -- AstroLSP config
      {
        "AstroNvim/astrolsp",
        opts = {
          features = {
            autoformat = true,
            codelens = true,
            inlay_hints = false,
            semantic_tokens = true,
          },
          ensure_installed = {
            -- This is internal for astrolsp; actual install managed by Mason plugins above
            "lua_ls", "tsserver", "jsonls", "gopls", "jdtls", "yamlls", "tailwindcss",
            "marksman", "bashls",
            "biome", "stylua", "prettier", "golangci-lint", "markdownlint",
            "luacheck", "yamllint", "taplo",
          },
          formatting = {
            format_on_save = true,
            disabled = { "lua_ls" },
          },
          linting = {
            enabled = true,
            linters_by_ft = {
              javascript = { "biome" },
              typescript = { "biome" },
              json = { "biome" },
              lua = { "luacheck" },
              markdown = { "markdownlint" },
              go = { "golangci_lint" },
              yaml = { "yamllint" },
              toml = { "taplo" },
            },
          },
          setup = function()
            local conform = require("conform")
            conform.setup({
              format_on_save = { timeout_ms = 1000, lsp_fallback = true },
              formatters_by_ft = {
                javascript = { "biome" },
                typescript = { "biome" },
                json = { "biome" },
                markdown = { "prettier" },
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
                yaml = { "prettier" },
                toml = { "taplo" },
              },
              formatters = {
                biome = {
                  command = "biome",
                  args = { "format", "--stdin-file-path", "$FILENAME" },
                  stdin = true,
                },
              },
            })

            local lint = require("lint")
            lint.linters_by_ft = {
              javascript = { "biome" },
              typescript = { "biome" },
              json = { "biome" },
              lua = { "luacheck" },
              markdown = { "markdownlint" },
              go = { "golangci_lint" },
              yaml = { "yamllint" },
              toml = { "taplo" },
            }

            vim.api.nvim_create_autocmd("BufWritePost", {
              callback = function()
                lint.try_lint()
              end,
            })
          end,
        },
      },
    },
    config = function()
      local servers = require("astrolsp").config.servers
      for _, server in ipairs(servers) do
        require("astrolsp").lsp_setup(server)
      end
    end,
  },
}
