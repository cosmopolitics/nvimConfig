vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.scrolloff = 10

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>pv', ':Oil<CR>')

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- { src = "https://github.com/" },
	{
			src = 'https://github.com/lewis6991/gitsigns.nvim',
			opts = {
					signs = {
							add = { text = "+" },
							change = { text = "~" },
							delete = { text = "_" },
							changedelete = { text = "~" },
					},
			},
	},

	{
			src ='https://github.com/saghen/blink.cmp',
			opts = {
					keymap = { preset = 'super-tab' },

					appearance = {
							use_nvim_cmp_as_default = true,
							nerd_font_variant = 'mono'
					},

					sources = {
							default = { 'lsp', 'path', 'snippets', 'buffer' },
					},

					signature = { enabled = true }
			},
	},
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
	{ src = 'https://github.com/lambdalisue/vim-suda' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/echasnovski/mini.nvim' },
	{ src = 'https://github.com/rafamadriz/friendly-snippets' },
	{ src = 'https://github.com/jiaoshijie/undotree' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
})
require 'mini.statusline'.setup { use_icons = true }
require("undotree").setup()
vim.keymap.set("n", "<leader>u", function()
		require("undotree").toggle()
end)
require('telescope').setup {}
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<leader>pp", builtin.git_files)
vim.keymap.set("n", "<leader>vh", builtin.help_tags)
vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({
				search = vim.fn.input("Grep > ")
		})
end)
vim.keymap.set("n", "<leader>pn", function()
		builtin.find_files {
				cwd = vim.fn.stdpath("config")
		}
end)


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
