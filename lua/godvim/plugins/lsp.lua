return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
  },

-- mason
{
  "williamboman/mason.nvim",
  version = "^1.0.0",
  cmd = { "Mason" },
  event = "User FilePost",
  opts = {},
},

-- mason-lspconfig
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
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {}
        end
    },
    automatic_installation = true,
  }
},

-- mason-tool-installer (for formatters/linters)
{
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "User FilePost",
  cmd = {
    "MasonToolsClean",
    "MasonToolsInstall",
    "MasonToolsInstallSync",
    "MasonToolsUpdate",
    "MasonToolsUpdateSync",
  },
  opts = {
    ensure_installed = {
      -- formatters
      "stylua",
      "prettier",
      "biome",
      "goimports",
      "gofmt",
      "taplo",

      -- linters
      "luacheck",
      "markdownlint",
      "golangci-lint",
      "yamllint",
    },
  },
},

-- conform.nvim (formatter)
{
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
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
  },
},

-- nvim-lint (linter)
{
  "mfussenegger/nvim-lint",
  event = "BufEnter",
  config = function()
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

   vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
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

	 {
  "aznhe21/actions-preview.nvim",

		opts = {},
		event = "LspAttach",
},

}
