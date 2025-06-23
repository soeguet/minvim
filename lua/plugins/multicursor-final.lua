return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        -- set({ "n", "v" }, "<up>", function()
        --   mc.lineAddCursor(-1)
        -- end)
        -- set({ "n", "v" }, "<down>", function()
        --   mc.lineAddCursor(1)
        -- end)
        set({ "n", "v" }, "<M-S-CR>up>", function()
            mc.lineSkipCursor(-1)
        end)
        set({ "n", "v" }, "<M-S-CR>down>", function()
            mc.lineSkipCursor(1)
        end)

        -- Add or skip adding a new cursor by matching word/selection
        set({ "n", "v" }, "<m-m>", function()
            mc.matchAddCursor(1)
        end)
        set({ "n", "v" }, "<M-m>", function()
            mc.matchAddCursor(1)
        end)
        set({ "n", "v" }, "<m-s>", function()
            mc.matchSkipCursor(1)
        end)
        set({ "n", "v" }, "<M-s>", function()
            mc.matchSkipCursor(1)
        end)
        set({ "n", "v" }, "<M-CR>", function()
            mc.matchAddCursor(-1)
        end)
        set({ "n", "v" }, "<M-C-S>", function()
            mc.matchSkipCursor(-1)
        end)

        -- Add all matches in the document
        set({ "n", "v" }, "<M-S-CR>", mc.matchAllAddCursors)

        -- You can also add cursors with any motion you prefer:
        -- set("n", "<right>", function()
        --     mc.addCursor("w")
        -- end)
        -- set("n", "<leader><right>", function()
        --     mc.skipCursor("w")
        -- end)

        -- Rotate the main cursor.
        set({ "n", "v" }, "<S-left>", mc.nextCursor)
        set({ "n", "v" }, "<S-right>", mc.prevCursor)

        -- Delete the main cursor.
        set({ "n", "v" }, "<leader>mm", mc.deleteCursor)

        -- Add and remove cursors with control + left click.
        set("n", "<m-leftmouse>", mc.handleMouse)

        -- Easy way to add and remove cursors using the main cursor.
        set({ "n", "v" }, "<c-q>", mc.toggleCursor)

        -- Clone every cursor and disable the originals.
        set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

        set("n", "<leader>mc", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler.
            end
        end)

        set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler.
            end
        end)

        -- bring back cursors if you accidentally clear them
        set("n", "<leader>mr", mc.restoreCursors, { desc = "Restore cursors" })

        -- Align cursor columns.
        set("n", "<leader>mA", mc.alignCursors, { desc = "Align cursors" })

        -- Split visual selections by regex.
        set("v", "<leader>mS", mc.splitCursors, { desc = "Split cursors" })

        -- Append/insert for each line of visual selections.
        set("v", "<leader>mi", mc.insertVisual, { desc = "Insert cursors" })
        set("v", "<leader>mV", mc.appendVisual, { desc = "Append cursors" })

        -- match new cursors within visual selections by regex.
        set("v", "<leader>mM", mc.matchCursors, { desc = "Match cursors" })

        -- Rotate visual selection contents.
        set("v", "<leader>mt", function()
            mc.transposeCursors(1)
        end, { desc = "Transpose cursors +1" })
        set("v", "<leader>mT", function()
            mc.transposeCursors(-1)
        end, { desc = "Transpose cursors -1" })

        -- Jumplist support
        set({ "v", "n" }, "<c-i>", mc.jumpForward)
        set({ "v", "n" }, "<c-o>", mc.jumpBackward)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
    -- config = function()
    --   local mc = require("multicursor-nvim")
    --
    --   mc.setup()
    --
    --   -- Add cursors above/below the main cursor.
    --   vim.keymap.set({ "n", "v" }, "<S-up>", function()
    --     mc.addCursor("k")
    --   end)
    --   vim.keymap.set({ "n", "v" }, "<S-down>", function()
    --     mc.addCursor("j")
    --   end)
    --
    --   -- Add a cursor and jump to the next word under cursor.
    --   vim.keymap.set({ "n", "v" }, "<M-m>", function()
    --     -- disable_hlsearch()
    --     mc.addCursor("*")
    --   end)
    --
    --   -- Jump to the next word under cursor but do not add a cursor.
    --   vim.keymap.set({ "n", "v" }, "<M-s>", function()
    --     -- disable_hlsearch()
    --     mc.skipCursor("*")
    --   end)
    --
    --   -- Rotate the main cursor.
    --   vim.keymap.set({ "n", "v" }, "<S-left>", mc.nextCursor)
    --   vim.keymap.set({ "n", "v" }, "<S-right>", mc.prevCursor)
    --
    --   -- Delete the main cursor.
    --   vim.keymap.set({ "n", "v" }, "<leader>md", mc.deleteCursor, { desc = "Delete cursor" })
    --
    --   -- Add and remove cursors with control + left click.
    --   vim.keymap.set("n", "<m-leftmouse>", mc.handleMouse)
    --
    --   vim.keymap.set({ "n", "v" }, "<c-q>", function()
    --     if mc.cursorsEnabled() then
    --       -- Stop other cursors from moving.
    --       -- This allows you to reposition the main cursor.
    --       mc.disableCursors()
    --     else
    --       mc.addCursor()
    --     end
    --   end)
    --
    --   vim.keymap.set("n", "<leader>mc", function()
    --     if not mc.cursorsEnabled() then
    --       mc.enableCursors()
    --     elseif mc.hasCursors() then
    --       mc.clearCursors()
    --     else
    --       -- Default <esc> handler.
    --     end
    --   end, { desc = "Clear cursors" })
    --
    --   vim.keymap.set("n", "<esc>", function()
    --     if not mc.cursorsEnabled() then
    --       mc.enableCursors()
    --     elseif mc.hasCursors() then
    --       mc.clearCursors()
    --     else
    --       -- enable_hlsearch()
    --       vim.cmd("nohlsearch")
    --     end
    --   end)
    --
    --   -- Align cursor columns.
    --   vim.keymap.set("n", "<leader>ma", mc.alignCursors, { desc = "Align cursors" })
    --
    --   -- Split visual selections by regex.
    --   vim.keymap.set("v", "S", mc.splitCursors)
    --
    --   -- Append/insert for each line of visual selections.
    --   vim.keymap.set("v", "I", mc.insertVisual)
    --   vim.keymap.set("v", "A", mc.appendVisual)
    --
    --   -- match new cursors within visual selections by regex.
    --   vim.keymap.set("v", "M", mc.matchCursors)
    --
    --   -- Rotate visual selection contents.
    --   vim.keymap.set("v", "<leader>t", function()
    --     mc.transposeCursors(1)
    --   end)
    --   vim.keymap.set("v", "<leader>T", function()
    --     mc.transposeCursors(-1)
    --   end)
    --
    --   -- Customize how cursors look.
    --   vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
    --   vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
    --   vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    --   vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    -- end,
}
