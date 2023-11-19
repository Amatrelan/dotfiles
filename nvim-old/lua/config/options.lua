vim.wo.number = true
vim.wo.relativenumber = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.hlsearch = false
vim.o.mouse = 'a'

vim.o.wrap = true
vim.o.breakindent = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = true
vim.o.smartindent = true
vim.o.scrolloff = 20

vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.o.swapfile = false

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
