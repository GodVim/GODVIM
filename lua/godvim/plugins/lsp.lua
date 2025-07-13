return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
          handlers = {
            function(server)
              require("astrolsp").lsp_setup(server)
            end,
          },
        },
        config = function(_, opts)
          -- Register servers AstroLSP manages before Mason setup
          require("astrolsp.mason-lspconfig").register_servers()
          require("mason-lspconfig").setup(opts)
        end,
      },
      {
        "AstroNvim/astrolsp",
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
            -- add formatters and linters you want mason to install
            "biome",
            "stylua",
            "prettier",
            "golangci-lint",
            "markdownlint",
            "luacheck",
            "yamllint",
            "taplo",
          },
          formatting = {
            format_on_save = true,
            disabled = { "lua_ls" }, -- use stylua via conform instead
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
            -- Setup conform.nvim formatting
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

            -- Setup nvim-lint
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
      -- Setup all servers AstroLSP manages after Mason and mason-lspconfig
      local servers = require("astrolsp").config.servers
      for _, server in ipairs(servers) do
        require("astrolsp").lsp_setup(server)
      end
    end,
  },
}
