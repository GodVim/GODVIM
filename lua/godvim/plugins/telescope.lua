return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'andrew-george/telescope-themes',
	},
	cmd = "Telescope",
	config = function()
		-- load extension
		local telescope = require('telescope')
		telescope.load_extension('themes')
	end
}
