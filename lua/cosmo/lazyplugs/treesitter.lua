return {
  {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "ocaml", "html", "css", "go", },
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
}
