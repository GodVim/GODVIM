vim.loader.enable()
local opt = vim.opt
local o = vim.o

--o.foldcolumn = '1'
--o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--o.foldlevelstart = 99
--o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'

--vim.wo.statuscolumn = "%=%l%=%s%C"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.laststatus = 3
opt.smoothscroll = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

opt.updatetime = 200
opt.clipboard:append("unnamedplus")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
