return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"zeioth/garbage-day.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"nvim-java/nvim-java",
			ft = "java",
		},
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		mason.setup()

		local servers = {
			"lua_ls",
			"ruff",
			"jsonls",
			"yamlls",
			"pyright",
			"marksman",
			"jdtls",
		}

		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		require("java").setup()
		lspconfig.jdtls.setup({})
		lspconfig.lua_ls.setup({})
		lspconfig.jsonls.setup({})
		lspconfig.ruff.setup({})
		lspconfig.yamlls.setup({})
		lspconfig.pyright.setup({})
		lspconfig.marksman.setup({})
	end,
}
