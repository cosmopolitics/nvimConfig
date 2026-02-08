return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

      -- linters
      'mfussenegger/nvim-lint',

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      vim.lsp.config["basedpyright"] = {
        manual_install = true,
        cmd = { "/run/current-system/sw/bin/basedpyright-langserver", "--stdio" },
      }

      vim.lsp.config["lua_ls"] = {
        manual_install = true,
        cmd = { "/run/current-system/sw/bin/lua-language-server" },
        settings = {
          Lua = {
            workspace = {
              userThirdParty = { os.getenv("HOME") .. "/.local/share/LuaAddons/" },
              checkThirdParty = "Apply",
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/love2d/library",
              },
            },
          },
        },
      }
      vim.lsp.config["clangd"] = {
        manual_install = true,
        -- cmd = { "/run/current-system/sw/bin/clangd" },
      }
      vim.lsp.config["nil_ls"] = {
        manual_install = true,
        -- cmd = { "/run/current-system/sw/bin/nil" },
      }
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("zls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ocamllsp")
      vim.lsp.enable("clangd")
      vim.lsp.enable("nil_ls")
      vim.lsp.enable("gopls")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          local builtin = require("telescope.builtin")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })
          vim.keymap.set("n", "<space>ww", function()
            builtin.diagnostics({ root_dir = true })
          end, { buffer = 0 })
        end,
      })

      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

      vim.keymap.set("", "<leader>l", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
        else
          vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
        end
      end, { desc = "Toggle lsp_lines" })
    end,
  },
}
