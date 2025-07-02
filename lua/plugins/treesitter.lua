return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts= {}
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            --"nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function ()
            require'nvim-treesitter.configs'.setup {
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
                        init_selection = "<M-=>",
                        node_incremental = false,
                        scope_incremental = "<M-=>",
                        node_decremental = "<M-->",
                    },
                },
            }
        end
    }
}
