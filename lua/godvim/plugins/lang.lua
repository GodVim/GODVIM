return {
{
  "ray-x/go.nvim",
    event = "User FilePost",
  dependencies = {
    "ray-x/guihua.lua",
  },
  opts = {},
  config = function(lp, opts)
    require("go").setup(opts)
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
      require('go.format').goimports()
      end,
      group = format_sync_grp,
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
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
