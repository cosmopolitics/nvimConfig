return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function ()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        dark = "mocha",
        default_integrations = true,
      },
      transparent_background = true, -- disables setting the background color.
      dim_inactive = {
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        harpoon = true,
        telescope = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
