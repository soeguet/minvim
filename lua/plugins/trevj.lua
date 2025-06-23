return {
    "AckslD/nvim-trevJ.lua",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.api.nvim_create_user_command("SplitStuff", function()
            require("trevj").format_at_cursor()
        end, { desc = "Split stuff" })

        vim.keymap.set("n", "<M-J>", function()
            require("trevj").format_at_cursor()
        end, { desc = "split code per line at cursor" })

        require("trevj").setup({
            containers = {
                lua = {
                    table_constructor = { final_separator = ",", final_end_line = true },
                    arguments = { final_separator = false, final_end_line = true },
                    parameters = { final_separator = false, final_end_line = true },
                },
                typescriptreact = {
                    table_constructor = {
                        final_separator = ",",
                        final_end_line = true,
                    },
                    arguments = {
                        final_separator = false,
                        final_end_line = true,
                    },
                    parameters = {
                        final_separator = false,
                        final_end_line = true,
                    },
                },
                typescript = {
                    table_constructor = {
                        final_separator = ",",
                        final_end_line = true,
                    },
                    arguments = {
                        final_separator = false,
                        final_end_line = true,
                    },
                    parameters = {
                        final_separator = false,
                        final_end_line = true,
                    },
                },
            },
        })
    end,
}
