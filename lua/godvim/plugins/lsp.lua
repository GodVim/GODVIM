return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      local servers = require("astrolsp").config.servers
      for _, server in ipairs(servers) do
        require("astrolsp").lsp_setup(server)
      end
    end,
  },

  -- mason
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    cmd = { "Mason" },
    event = "User FilePost",
    opts = {},
  },

  -- mason lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0.0",
    event = "User FilePost",
    opts = {
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "jsonls",
        "gopls",
        "java-language-server",
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

  -- mason tool installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "User FilePost",
    cmd = { "MasonToolsClean", "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsUpdateSync" },
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
    }
  },

  -- astrolsp
  {
    "AstroNvim/astrolsp",
    event = "User FilePost",
    opts = {
      features = {
        autoformat = true,
        codelens = true,
        inlay_hints = false,
        semantic_tokens = true,
      },
      ensure_installed = {
        "lua_ls", "tsserver", "jsonls", "gopls", "java-language-server", "yamlls", "tailwindcss",
        "marksman", "bashls", "biome", "stylua", "prettier", "golangci-lint",
        "markdownlint", "luacheck", "yamllint", "taplo",
      },
      formatting = {
        format_on_save = true,
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
    },
  },
}
