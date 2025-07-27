vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>pv', ':Oil<CR>')

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- { src = "https://github.com/" },
})
require("oil").setup({
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},

})

vim.lsp.enable({
	"lua_ls",
	"basedpyright",
})
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

vim.cmd("colorscheme rose-pine")
vim.cmd(":hi statusline guibg=NONE")
