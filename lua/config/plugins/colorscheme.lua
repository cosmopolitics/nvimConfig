--return {
--  "catppuccin/nvim",
--  name = "catppuccin",
--  priority = 1000,
--  config = function()
--    require("catppuccin").setup({
--      flavour = "mocha", -- latte, frappe, macchiato, mocha
--      background = { -- :h background
--        light = "latte",
--        dark = "mocha",
--      },
--      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--        comments = { "italic" }, -- Change the style of comments
--        conditionals = { "italic" },
--      },
--      default_integrations = true,
--      integrations = {
--        cmp = true,
--        gitsigns = true,
--        nvimtree = true,
--        treesitter = true,
--        mini = {
--          enabled = true,
--          indentscope_color = "",
--        },
--      },
--    })
--    vim.cmd.colorscheme "catppuccin"
--  end,
--}

-- lua/plugins/rose-pine.lua
return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    })
    vim.cmd.colorscheme "rose-pine"
  end
}
