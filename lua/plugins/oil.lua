
vim.keymap.set("n", "<leader>ee", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "\\\\", "<CMD>Oil<CR>", { desc = "Open parent directory" })


return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ["<C-p>"] = false,  -- Deaktiviert das Standard-Mapping
            ["<C-k>"] = "actions.preview",  -- Beispiel: Ctrl+k für Preview
        },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
