return {
	-- Lsp Config
	{ "neovim/nvim-lspconfig", event = "InsertEnter" },

	-- Mason
	{
		"mason-org/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
		},
		version = "^1.0.0",
		opts = {
			ui = {
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ",
				},
			},
			max_concurrent_installers = 10,
			registries = {
				"github:nvim-java/mason-registry",
				"github:mason-org/mason-registry",
			},
		},
	},

	-- Mason Lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		event = "User FilePost",
		version = "^1.0.0",
		opts = {
			automatic_enable = true,
			handlers = {
				function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
			},
			ensure_installed = {
				"jsonls",
				"biome",
				"astro",
				"tailwindcss",
				"marksman",
			},
			automatic_installation = true,
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
