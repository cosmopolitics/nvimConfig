return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  lazy = false,
  opts = {
    auto_close = true,
    focus = true;
  },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>qb",
      "<cmd>Trouble diagnostics toggle focus=false<cr>",
      desc = "Diagnostics in background(Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false pinned=true win.relative=win<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>ql",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>qf",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
