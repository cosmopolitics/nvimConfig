return {
  -- init.lua:
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup {
        file_previewer = require('telescope.previewers').vim_buffer_cat.new {
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

      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function(args)
          if args.data.filetype ~= "help" then
            vim.wo.number = true
          elseif args.data.bufname:match("*.csv") then
            vim.wo.wrap = false
          end
        end,
      })
    end,
  },
}
