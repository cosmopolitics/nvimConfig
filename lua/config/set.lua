local set = vim.opt

set.guicursor = ""
set.cmdheight = 0

set.nu = true
set.relativenumber = true

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

set.smartindent = true

set.wrap = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true

-- set.termguicolors = true

set.scrolloff = 10
set.signcolumn = "yes"
set.isfname:append("@-@")

set.updatetime = 50

set.colorcolumn = "800"

vim.g.mapleader = " "
