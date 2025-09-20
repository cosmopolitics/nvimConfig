return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config('lua_ls', {cmd = '/run/current-system/sw/bin/lua-lsp'})
      vim.lsp.config('clangd', { capabilities = capabilities })
      vim.lsp.config('zls', { capabilities = capabilities })
      vim.lsp.config('nil_ls', { capabilities = capabilities })
      vim.lsp.config('basedpyright', { capabilities = capabilities })
      vim.lsp.config('ocamllsp', { capabilities = capabilities })
      vim.lsp.enable = true;
    end,
  },
}
