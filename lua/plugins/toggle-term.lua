
return {
    "akinsho/toggleterm.nvim",
    opts = {},
    keys = {
        { "<c-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
        { "", "<cmd>ToggleTerm<cr>", mode = {"n","t"}, desc = "Toggle Terminal" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle Vertical Terminal" },
    }
}
