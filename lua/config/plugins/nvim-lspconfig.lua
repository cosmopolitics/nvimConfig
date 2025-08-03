return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      --require("lspconfig").pylyzer.setup { capabilities = capabilities }
      require("lspconfig").glsl_analyzer.setup { capabilities = capabilities }
      require("lspconfig").clangd.setup { capabilities = capabilities }
      require("lspconfig").zls.setup { capabilities = capabilities }
      require("lspconfig").nil_ls.setup { capabilities = capabilities }
      require("lspconfig").basedpyright.setup { capabilities = capabilities }
      require("lspconfig").elp.setup { capabilities = capabilities }
      require("lspconfig").hls.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end,
      })
    end,
  },
}
