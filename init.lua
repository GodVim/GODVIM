vim.api.nvim_echo({
	{ "This repository is not meant to be used as a direct Neovim configuration\n", "ErrorMsg" },
	{ "Press any key to exit...",                                                   "MoreMsg" },
}, true, {})

vim.fn.getchar()
vim.cmd.quit()
