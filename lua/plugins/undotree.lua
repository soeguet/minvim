return {
    "mbbill/undotree",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "toggle undotree" })
    end,
}
