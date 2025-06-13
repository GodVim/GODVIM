vim.loader.enable()
local opt = vim.opt
local o = vim.o

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'


o.cmdheight = 0
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.laststatus = 3
opt.smoothscroll = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.signcolumn = "yes"


opt.updatetime = 200
opt.clipboard:append("unnamedplus")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
