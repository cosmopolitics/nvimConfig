return {
  -- init.lua:
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {}
        }
      }
      vim.keymap.set("n", "<leader>pf", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<leader>pa", require('telescope.builtin').help_tags)
      vim.keymap.set("n", "<leader>pn", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end,
  }
}
