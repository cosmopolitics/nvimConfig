return {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.5",
    dependencies = {'nvim-lua/plenary.nvim'},

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end,

--    {
--        "ThePrimeagen/harpoon",
--        branch = "harpoon2",
--        dependencies = { "nvim-lua/plenary.nvim" },
--
--        config = function ()
--            local harpoon = require("harpoon")
--
--            -- REQUIRED
--            harpoon:setup()
--            -- REQUIRED
--
--            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
--            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
--            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
--            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
--            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
--            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
--
--        end
--    }
}
