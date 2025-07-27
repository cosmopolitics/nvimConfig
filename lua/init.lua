require "set"
require "remap"
require "float_terminal"

vim.pack.add({
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
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
    src = 'https://github.com/saghen/blink.cmp',
    opts = {
      keymap = { preset = 'super-tab' },
      completion = { documentation = { auto_show = true } },
      signature = { enabled = true }
    },
  },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/lambdalisue/vim-suda' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/jiaoshijie/undotree' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
})
require 'mini.statusline'.setup { use_icons = true }

require("undotree").setup {}
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

local capabilities = require('blink.cmp').get_lsp_capabilities()
require("lspconfig").lua_ls.setup { capabilities = capabilities }
require("lspconfig").clangd.setup { capabilities = capabilities }
require("lspconfig").zls.setup { capabilities = capabilities }
require("lspconfig").nil_ls.setup { capabilities = capabilities }
require("lspconfig").basedpyright.setup { capabilities = capabilities }
require("lspconfig").elp.setup { capabilities = capabilities }


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end
      })
    end
  end,
})

local augroup = vim.api.nvim_create_augroup
local CosmoGroup = augroup('Cosmo', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd('LspAttach', {
  group = CosmoGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
  end
})

vim.cmd("colorscheme rose-pine")
vim.cmd(":hi statusline guibg=NONE")
