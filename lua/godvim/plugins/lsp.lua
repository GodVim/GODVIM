return {

	-- garbage
	{
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "LspAttach",
  opts = {
    -- your options here
  }
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
}
