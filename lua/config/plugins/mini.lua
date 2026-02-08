return {
  {
    'nvim-mini/mini.statusline',
    version = false,
    config = function()
      require('mini.statusline').setup()
    end
  },
  {
    'nvim-mini/mini.ai',
    version = false,
    config = function()
      require('mini.ai').setup()
    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^7',
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.expandtab = true
        end,
      })
    end
  },
}
