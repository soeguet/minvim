return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function(_, opts)
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup(opts)
        -- REQUIRED

        vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "Add current file to harpoon" })
        vim.keymap.set("n", "<leader>eh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon quick menu" })

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Select first harpoon file" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Select second harpoon file" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Select third harpoon file" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Select fourth harpoon file" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<M-Left>", function() harpoon:list():prev() end, { desc = "Go to previous harpoon file" })
        vim.keymap.set("n", "<M-Right>", function() harpoon:list():next() end, { desc = "Go to next harpoon file" })

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    end
}
