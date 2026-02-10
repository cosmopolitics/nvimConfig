return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require 'nvim-treesitter'.install({
      "c",
      "lua",
      "nix",
      "rust",
      "query",
      "go",
      "python",
      "sql"
    })
  end
}
