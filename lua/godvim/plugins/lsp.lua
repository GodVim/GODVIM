return {
    "AstroNvim/astrolsp",
    event = "User FilePost",
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
      },
      formatting = {
        format_on_save = true,
        disabled = { "lua_ls" }, -- Use stylua via conform instead
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
      capabilities = {},
      handlers = {},
      setup = function()
        local conform = require("conform")
        conform.setup({
          format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = true,
          },
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
  }
