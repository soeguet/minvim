return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "\\", -- set to `false` to disable one of the mappings
                node_incremental = "\\",
                scope_incremental = "grc",
                node_decremental = "|",
            },
        },
    },
}
