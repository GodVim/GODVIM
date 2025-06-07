vim.loader.enable()
local opt = vim.opt
local o = vim.o

opt.foldlevel = 99
o.foldcolumn = '1'
--o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--o.foldlevelstart = 99
o.foldenable = true

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
display.action_palette.provider = "telescope"
