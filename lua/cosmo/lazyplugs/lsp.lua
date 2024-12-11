local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    config = function()
        require("mason").setup{
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
        }
        require("mason-lspconfig").setup{
            ensure_installed = {
                'lua_ls',
            },
            handlers = {
                function (server_name)
                    require("lspconfig")[server_name].setup({
                          capabilities = capabilities,
                    })
                end,
            }
        }
    end,
}
