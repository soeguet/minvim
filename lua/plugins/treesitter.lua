return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {}
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            --"nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
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
                        init_selection = "<M-=>",
                        node_incremental = false,
                        scope_incremental = "<M-=>",
                        node_decremental = "<M-->",
                    },
                },
                highlight = {
                    enable = true,
                    custom_captures = {
                        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
                        ["foo.bar"] = "Identifier",
                    },
                    -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
                    additional_vim_regex_highlighting = false,
                },
            },
        config = function(_,opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    }
}
