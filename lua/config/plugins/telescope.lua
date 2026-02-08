return {
  -- init.lua:
  {
    "nvim-telescope/telescope.nvim",
    tag = "latest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup {
        file_previewer = require('telescope.previewers').cat.new {
          cmd = 'bat --style=numbers --color=always',
        },
        grep_previewer = require('telescope.previewers').vimgrep.new {
          cmd = 'bat --style=numbers --color=always',
        },
      }

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>pf", builtin.find_files)
      vim.keymap.set("n", "<leader>pg", builtin.git_files)
      vim.keymap.set("n", "<leader>vh", builtin.help_tags)
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({
          search = vim.fn.input("Grep > "),
        })
      end)
      vim.keymap.set("n", "<leader>pn", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end)
    end,
  },
}
