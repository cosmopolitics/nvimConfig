local lint = require('lint')
lint.linters_by_ft = {
  go = {
    'nilaway',
    'staticcheck',
  },
  nix = {
    'nix',
  }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
