-- Copilot configuration for Neovim 
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				trigger_on_accept = false,
				keymap = {
					accept = "<M-CR>",
					accept_word = "<M-l>",
					accept_line = "<M-k>",
					next = "<M-Bslash>",
					prev = "<M-[>",
					dismiss = "<M-x>",
				},
			},
            panel = {
                enabled = false,
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
