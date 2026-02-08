return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require "rose-pine".setup {
        variant = "moon",
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      }
      vim.cmd.colorscheme "rose-pine"
    end,
  },
  -- {
  --   "mvllow/modes.nvim",
  --   config = function()
  --     require("modes").setup()
  --   end
  -- },
}
