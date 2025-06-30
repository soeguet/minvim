return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "bash",
            "java",
            "javascript",
            "typescript",
            "html",
            "c",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "git_rebase",
            "go",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "python",
            "regex",
            "rust",
            "sql",
            "typescript",
            "vim",
            "yaml"
        },
        auto_install = true,
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "\\", -- set to `false` to disable one of the mappings
                node_incremectal = "\\",
                scope_incremental = "grc",
                node_decremental = "|",
            },
        },
    },
}
