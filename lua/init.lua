require("config.set")
require("config.remap")
require("config.lazy")
require("config.auto_update")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local CosmoGroup = augroup("Cosmo", {})
local yank_group = augroup("HighlightYank", {})

autocmd("FileType", {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end
})


autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

autocmd("LspAttach", {
  group = CosmoGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>gws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>god", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>gca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>grr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>grn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)
  end,
})
