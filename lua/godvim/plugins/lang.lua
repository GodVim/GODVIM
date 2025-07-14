return {
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
        "lua_ls", "jsonls", "gopls", "yamlls", "tailwindcss",
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

	-- Code Actions
	{
		"rachartier/tiny-code-action.nvim",
		event = "LspAttach",
		opts = {},
	},
}
