return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        version = "^1.0.0",
        opts = {
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
        },
      },

      {
        "mason-org/mason-lspconfig.nvim",
        version = "^1.0.0",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
          handlers = {
            function(server)
              require("astrolsp").lsp_setup(server)
            end,
          },
          ensure_installed = {
            -- only LSP servers here
            "lua_ls",
            "tsserver",
            "jsonls",
            "gopls",
            "jdtls",
            "yamlls",
            "tailwindcss",
            "marksman",
            "bashls",
          },
          automatic_installation = true,
        },
        config = function(_, opts)
          require("astrolsp.mason-lspconfig").register_servers()
          require("mason-lspconfig").setup(opts)
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
            -- this is still useful for astrolsp internal tracking,
            -- but actual install handled by mason/mason-lspconfig as above
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
      -- Setup all servers AstroLSP manages after Mason and mason-lspconfig are ready
      local servers = require("astrolsp").config.servers
      for _, server in ipairs(servers) do
        require("astrolsp").lsp_setup(server)
      end
    end,
  },
}
