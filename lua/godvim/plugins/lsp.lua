return {
  {
    "JavaHello/spring-boot.nvim",
    ft = {"java", "yaml", "jproperties"},
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      require('spring_boot').init_lsp_commands()
-- 添加 spring-boot jdtls 扩展 jar 包
require("lspconfig").jdtls.setup {
  init_options = {
    bundles = require("spring_boot").java_extensions(),
  },
}
    end,
    ---@type bootls.Config
    opts = {}
  },
  
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
        "jsonls",
        "gopls",
        "yamlls",
        "tailwindcss",
        "marksman",
        "bashls",
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
        "astro",
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
        "lua_ls", "jsonls", "gopls", "jdtls", "yamlls", "tailwindcss",
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
