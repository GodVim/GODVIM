return {
	'neovim/nvim-lspconfig',
	event = "InsertEnter",
	dependencies = {
		'zeioth/garbage-day.nvim',
		'williamboman/mason.nvim',
		{
			'nvim-java/nvim-java',
			event = "InsertEnter"
		},
		'williamboman/mason-lspconfig.nvim',
	},
	config = function()
		local mason = require('mason')
		local mason_lspconfig = require('mason-lspconfig')
		local lspconfig = require('lspconfig')

		mason.setup()

		local servers = {
			'lua_ls',
			'jdtls',
			'ruff',
			'jsonls',
			'yamlls',
			'pyright',
			'marksman',
		}

		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		require('java').setup()

		lspconfig[lua_ls].setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }, -- Tell lua_ls that `vim` is a global
					},
				},
			},
		})
		for _, server in ipairs(servers) do
			lspconfig[server].setup({})
		end
	end,
}
