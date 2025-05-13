vim.loader.enable()
local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.laststatus = 3
opt.smoothscroll = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 200
opt.clipboard:append("unnamedplus")
opt.statuscolumn = "%{%v:lua.custom_statuscol()%}"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
