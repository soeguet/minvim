return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false,
				hide_during_completion = true,
				debounce = 75,
				trigger_on_accept = false,
				keymap = {
					accept = "<TAB>",
					accept_word = "<C-l>",
					accept_line = false,
					next = "<c-]>",
					prev = "<C-/>",
					dismiss = "<c-x>",
				},
			},
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>"
                },
                layout = {
                    position = "right",
                    ratio = 0.4
                },
            },
		})

        vim.api.nvim_set_hl(0, "CopilotSuggestion", {
            fg = "#ff6961",
            -- bg = "#000000",
            blend = 30,
            undercurl = false,  -- Subtile Unterstreichung
            sp = "#665c54"     -- Farbe der Unterstreichung

        })
	end,
}
