return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("undotree").setup()
    vim.keymap.set("n", "<leader>u", function()
      require("undotree").toggle()
    end)
  end,
  -- keys = { -- load the plugin only when using it's keybinding:
  --   { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  -- },
}
