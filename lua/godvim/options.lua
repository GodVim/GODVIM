vim.loader.enable()
local opt = vim.opt
local o = vim.o

o.showtabline = 2
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

if vim.g.neovide then
    vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

opt.updatetime = 200
opt.clipboard:append("unnamedplus")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
vim.opt.history = 50 -- Number of commands to remember in a history table (per buffer).

vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

opt.synmaxcol = 500
